//
//  AddressManager.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import Foundation
import CoreLocation
import MapKit
import RealmSwift
import _MapKit_SwiftUI
import Alamofire


class AddressManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @Published var geoCatEventList:[EventCat]=[]
    @Published private var region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    // var test_map :CLLocationCoordinate2D?
    // var test_mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599)
    // let test_region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880), span: MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)) //남산
    
    @Published var annotations: [MKPointAnnotation] = []
    @Published private var annotationViews: [MKAnnotationView] = []
    @Published var dummyCatCareLocation:CatCareLocation?
    @Published var customAnnotation:CustomAnnotation?
    @Published var mapView: MKMapView = .init()
    @Published var isChanging: Bool = false // 지도의 움직임 여부를 저장하는 프로퍼티
    @Published var currentPlace: String = "" // 현재 위치의 도로명 주소를 저장하는 프로퍼티
    
    private var manager: CLLocationManager = .init()
    @Published var currentGeoPoint: CLLocationCoordinate2D? // 현재 위치를 저장하는 프로퍼티
    @Published var currentGeoLocation: CLLocation? // 현재 위치를 저장하는 프로퍼티
    var annotationsInCircle: [MKPointAnnotation] = []
    
    @Published var mainUpdateResion:MKCoordinateRegion?
    
    
    @Published var arrCatsEventList:[EventCat]?
    override init() {
        super.init()
        // loadCatEventAnnotationsFromRealm()
        locdCatEventFromCareCatAPI()
        self.configureLocationManager()
    }
    
    static let shared = AddressManager()
    // MARK: - 사용자의 위치 권한 여부를 확인하고 요청하거나 현재 위치 MapView를 이동하는 메서드
    func configureLocationManager() {
        mapView.delegate = self
        manager.delegate = self
        
        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            // mapView.showsUserLocation = true // 사용자의 현재 위치를 확인할 수 있도록
            // manager.startUpdatingLocation()
            self.moveFocusOnUserLocation()
            self.addMyLocationMarker()
            // configureLocationManager() 메서드 내부의 해당 부분을 수정합니다.
            
        }
    }
    
    // MARK: - 특정 반경을 표시하는 메서드
    func addCircleOverlay(center: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let circle = MKCircle(center: center, radius: radius)
        let circleRenderer = MKCircleRenderer(circle: circle)
        circleRenderer.fillColor = .red
        circleRenderer.alpha = 0.5
        mapView.addOverlay(circleRenderer as! MKOverlay)
    }
    
    // MARK: - 사용자의 현재 위치로 MapView를 이동하는 메서드
    func moveFocusOnUserLocation() {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        if let location = manager.location {
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mainUpdateResion = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            
            // 반경 3km 이내 마커를 표시합니다.
            //       let circle = MKCircle(center: location.coordinate, radius: 3000)
            //       let circleRenderer = MKCircleRenderer(circle: circle)
            //       circleRenderer.fillColor = .red
            //       circleRenderer.alpha = 0.5
            // if circleRenderer is MKOverlay {
            //     mapView.addOverlay(circleRenderer as! MKOverlay)
            //      }
            
            let circle = MKCircle(center: location.coordinate, radius: 3000)
            mapView.addOverlay(circle)
            
        } else {
            // 사용자의 위치가 아직 가져오지 못했다면, 대한민국 남산으로 지도의 위치를 표시
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let defaultLocation = CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880) // 기본 위치
            let region = MKCoordinateRegion(center: defaultLocation, span: span)
            mapView.setRegion(region, animated: true)
        }
        self.addMyLocationMarker()
    }
    
    // MARK: - 내 위치에 마커를 표시하는 메서드
    func addMyLocationMarker() {
        if let location = manager.location {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = "내 위치"
            mapView.addAnnotation(annotation)
        }
    }
    
    // MARK: - MapView에서 화면이 이동하면 호출되는 메서드
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        DispatchQueue.main.async {
            self.isChanging = true
        }
    }
    
    
    func isTarketLocation() {
        if let currentGeoLocation = currentGeoLocation {
            print("현재 위치 : \(currentGeoLocation)")
            
            
        }
    }
    // MARK: - MapView에서 화면 이동이 종료되면 호출되는 메서드
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated: Bool) {
        //주소록 불러오기
        let location: CLLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        self.convertLocationToAddress(location: location)
        
        //고양이 로드
        // loadCatEventAnnotationsFromRealm()
        
        //고양이 로드
        // let filteredTrackingEvents = getEventCoodinateRealm()
        
        
        // 현재 위치
        let catLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        
        // 반경 3km 이내 마커
        let circle = MKCircle(center: catLocation.coordinate, radius: 3000)
        
        
        
        // 지도에 마커 표시
        // for filteredTrackingEvent in filteredTrackingEvents {
        //     if Double(filteredTrackingEvent.event_latitude) != 0.0 && Double(filteredTrackingEvent.event_longitude) != 0.0{
        //         let annotation = MKPointAnnotation()
        //         annotation.coordinate = CLLocationCoordinate2D(latitude: Double(filteredTrackingEvent.event_longitude), longitude: Double(filteredTrackingEvent.event_latitude))
        //         // annotation.title = filteredTrackingEvent.eve
        //         print("event 마커 : \(filteredTrackingEvent.event_longitude)")
        //         mapView.addAnnotation(annotation)
        //         // mapView.addAnnotation(filteredTrackingEvent as! MKAnnotation)
        //     }
        // }
        
        // print("화면 이동이 종료 markers : \(markers)")
        // for marker in markers {
        // let annotation = MKPointAnnotation()
        // annotation.coordinate = CLLocationCoordinate2D(latitude: marker.coordinate.latitude, longitude: marker.coordinate.longitude)
        // annotation.title = marker.title
        
        // let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        // mapView.addAnnotation(annotation)
        // mapView.setRegion(region, animated: true)
        // uiView을 MKMapView로 캐스팅
        // print("화면 이동이 종료 markers  annotation.coordinate : \(marker.coordinate.latitude),annotation.coordinate : \(marker.coordinate.longitude) ")
        // }
        
        // 위도경도 업데이트
        DispatchQueue.main.async {
            self.isChanging = false
        }
        
        // 반경 3km 내에 있는 위도경도 확인
        // let circle = MKCircle(center: location.coordinate, radius: 3000)
        // let annotationsInCircle = markers.filter { circle.contains($0.coordinate) }
        // print("반경 3km 내에 있는 위도경도 : \(annotationsInCircle)")
    }
    
    // Realm에서 불러온 데이터 에서 위도 경도 빼내기
    func getEventCoodinateRealm() -> [Tracking]  {
        // 트랙킹 Realm 객체를 읽습니다.
        let trackingEvents = RealmHelper.shared.read(Tracking.self)
        
        let realm = try! Realm()
        
        // `Tracking` 테이블에서 모든 데이터를 가져옵니다.
        // let trackingEvents = realm.objects(Tracking.self)
        
        
        // print("++> 제대로 불러오니? \(trackingEvents)")
        //저장된값중에 0.0 이 아닌값만 출력하기 test 중
        // latitude와 longitude 값이 0.0이 아닌 값만 필터링합니다.
        var filteredTrackingEvents = [Tracking]()
        
        for trackingEvent in trackingEvents {
            if Double(trackingEvent.event_latitude) != 0.0{
                filteredTrackingEvents.append(trackingEvent)
                print("++> 이벤트 캣 : \(filteredTrackingEvents)" )
            } else {
                print("이벤트 캣 0.0: \(trackingEvent.event_latitude)" )
            }
        }
        return filteredTrackingEvents
    }
    
    
    // MARK: - 특정 위치로 MapView의 Focus를 이동하는 메서드
    func mapViewFocusChange() {
        print("[SUCCESS] Map Focus Changed")
    }
    
    // MARK: - 사용자에게 위치 권한이 변경되면 호출되는 메서드 (LocationManager 인스턴스가 생성될 때도 호출)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            guard let location = manager.location else {
                print("[ERROR] No Location")
                return
            }
            self.currentGeoPoint = location.coordinate // 현재 위치를 저장하고
            self.mapViewFocusChange() // 현재 위치로 MapView를 이동
            self.convertLocationToAddress(location: location)
        }
    }
    
    // MARK: - 사용자의 위치가 변경되면 호출되는 메서드
    /// startUpdatingLocation 메서드 또는 requestLocation 메서드를 호출했을 때에만 이 메서드가 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("[SUCCESS] Did Update Locations")
        self.currentGeoLocation = locations.first
        
    }
    
    // MARK: - 사용자의 현재 위치를 가져오는 것을 실패했을 때 호출되는 메서드
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // MARK: - location을 도로명 주소로 변환해주는 메서드
    func convertLocationToAddress(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                return
            }
            guard let placemark = placemarks?.first else { return }
            self.currentPlace = "\(placemark.country ?? "") \(placemark.locality ?? "") \(placemark.name ?? "")"
            print("주소 : \(placemark.country ?? "") \(placemark.locality ?? "") \(placemark.name ?? "")")
        }
    }
    
    
    func locdCatEventFromCareCatAPI() {
        AF.request(CARE_CAT_SELECT_API_URL, method: .get).responseDecodable(of: [EventCat].self) { response in
            switch response.result {
            case .success(let value):
                print("성공 디코딩 EventItemViewModel: \(value)")
                self.arrCatsEventList = value
                self.filterTrackingFromEventCats()
                print("성공 디코딩 EventItemViewModel arrCats: \(self.arrCatsEventList)")
            case .failure(let error):
                print("실패 디코딩 EventItemViewModel : \(error.localizedDescription)")
            }
        }
    }
    
    func filterTrackingFromEventCats() {
        if let arrCatsEventList = arrCatsEventList {
            for eventItem in arrCatsEventList {
                let la = eventItem.coordinates[0]
                let lo = eventItem.coordinates[1]
                    if la != 0.0 && lo != 0.0 {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: la, longitude: lo)
                        //리스트 복수
                        print("++> 리얼엠에서 잘 불러왔니? 2 : \(la) , lo :\(lo)")
                        annotations.append(annotation)
                    }
                }
            }
            mapView.addAnnotations(annotations)
        }
    
    
    
    //고양이 CareRealmModel 이벤트 표시 realm 호출
    func loadCatEventAnnotationsFromRealm() {
        do {
            // deleteAll()
            
            let trackingDatas = RealmHelper.shared.read(Tracking.self)
            print("++> 리얼엠에서 잘 불러왔니? 1 : \(trackingDatas)")
            
            //test
            for aa in trackingDatas {
                print("++> 리얼엠에서 잘 불러왔니? 1-1 : \(aa.event_latitude) ")
            }
            var annotations: [MKPointAnnotation] = []
            
            for tracking in trackingDatas {
                if tracking.event_latitude != 0.0 && tracking.event_longitude != 0.0 {
                    
                    // 지도에 마커 표시
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: tracking.event_latitude, longitude: tracking.event_longitude)
                    
                    //리스트 복수
                    print("++> 리얼엠에서 잘 불러왔니? 2 : \(tracking.event_longitude)")
                    
                    annotations.append(annotation)
        
                }
            }
            mapView.addAnnotations(annotations)
        } catch {
            print("Error loading data from Realm: \(error)")
        }
    }
    
    // 어노테이션뷰 재사용 : 그림표시하기
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 식별자
        let identifier = "Custom"
        
        // 식별자로 재사용 가능한 AnnotationView가 있나 확인한 뒤 작업을 실행 (if 로직)
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            // 재사용 가능한 식별자를 갖고 어노테이션 뷰를 생성
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            // 콜아웃 버튼을 보이게 함
            annotationView?.canShowCallout = true
            // 이미지 변경
            // annotationView?.image = UIImage(systemName: "star.fill")
            // 
            if let image = UIImage(named: "OIGG") {
                annotationView?.image = image
                annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

            } else {
                // 이미지를 찾을 수 없는 경우에 대한 처리
            }
            
            // 상세 버튼 생성 후 액세서리에 추가 (i 모양 버튼)
            // 버튼을 만들어주면 callout 부분 전체가 버튼 역활을 합니다
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        }
        
        return annotationView
    }
    
    func loadTrackingEventAnnotationsFromRealm() {
        
        let filteredTrackingEvents = getEventCoodinateRealm()
        
        // 지도에 마커 표시
        for filteredTrackingEvent in filteredTrackingEvents {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(filteredTrackingEvent.event_latitude), longitude: Double(filteredTrackingEvent.event_longitude))
            // annotation.title = filteredTrackingEvent.event_name
            // annotation.title = filteredTrackingEvent.event_name?.description
            mapView.addAnnotation(annotation)
            print("++> 3 : \(filteredTrackingEvent.event_latitude)")
        }
        
    }
    
    func deleteAll() {
        RealmHelper.shared.realm.deleteAll()
    }
}


