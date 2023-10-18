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


class AddressManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @Published var annotations: [MKPointAnnotation] = []
    
    
    @Published var mapView: MKMapView = .init()
    @Published var isChanging: Bool = false // 지도의 움직임 여부를 저장하는 프로퍼티
    @Published var currentPlace: String = "" // 현재 위치의 도로명 주소를 저장하는 프로퍼티
    
    private var manager: CLLocationManager = .init()
    private var currentGeoPoint: CLLocationCoordinate2D? // 현재 위치를 저장하는 프로퍼티
    var annotationsInCircle: [MKPointAnnotation] = []
    
    
    override init() {
        super.init()
        
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
            mapView.showsUserLocation = true // 사용자의 현재 위치를 확인할 수 있도록
            manager.startUpdatingLocation()
            
            
            // configureLocationManager() 메서드 내부의 해당 부분을 수정합니다.
            if let location = manager.location {
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            } else {
                // 사용자의 위치가 아직 가져오지 못했다면, 대한민국 남산으로 지도의 위치를 표시
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let defaultLocation = CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880) // 기본 위치
                let region = MKCoordinateRegion(center: defaultLocation, span: span)
                mapView.setRegion(region, animated: true)
            }
            
            
            // 대한민국 남산으로 지도의 위치를 표시 latitude: 37.5514, longitude: 126.9880
            // 현재 위치로 지도의 위치를 표시
            // if let location = manager.location {
            //     let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            //     let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.501151, longitude: 127.005278), span: span)
            //     mapView.setRegion(region, animated: true)
            // } else {
            //     // 사용자의 위치가 아직 가져오지 못했다면, 대한민국 남산으로 지도의 위치를 표시
            //     let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            //     let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880), span: span)
            //     mapView.setRegion(region, animated: true)
            // }
        }
    }
    
    // MARK: - MapView에서 화면이 이동하면 호출되는 메서드
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        DispatchQueue.main.async {
            self.isChanging = true
        }
    }
    
    // MARK: - MapView에서 화면 이동이 종료되면 호출되는 메서드
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated: Bool) {
        //주소록 불러오기
        let location: CLLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        self.convertLocationToAddress(location: location)
        
        //고양이 로드
        loadCatEventAnnotationsFromRealm()
        
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
        //TODO : 저장된값중에 0.0 이 아닌값만 출력하기 test 중
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
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        // let region = MKCoordinateRegion(center: self.currentGeoPoint ??  CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880), span: span) //현재위치
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880), span: span) //남산
        mapView.setRegion(region, animated: true)
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
    
    //고양이 CareRealmModel 이벤트 표시 realm 호출
    func loadCatEventAnnotationsFromRealm() {
        do {
            
            // deleteAll()
            // 현재 위치
            // let catLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            //
            // let center = CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            
            // 지도의 영역을 현재 위치로 설정
            // let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            // mapView.setRegion(region, animated: true)
            
            // deleteAll()
            
            // let realm = try Realm()
            // let trackingDatas = realm.objects(Tracking.self)
            
            let trackingDatas = RealmHelper.shared.read(Tracking.self)
            print("++> 리얼엠에서 잘 불러왔니? 1 : \(trackingDatas)")
            
            for aa in trackingDatas {
                print("++> 리얼엠에서 잘 불러왔니? 1-1 : \(aa.event_latitude) ")
            }
            
            for tracking in trackingDatas {
                if tracking.event_latitude != 0.0 && tracking.event_longitude != 0.0 {
                   
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: tracking.event_latitude, longitude: tracking.event_longitude)
                    
                    print("++> 리얼엠에서 잘 불러왔니? 2 : \(tracking.event_longitude)")
                    
                    
                    // 지도에 마커 표시
                    let annotations = trackingDatas.map {
                        MKPointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: $0.event_latitude, longitude: $0.event_longitude))
                    }
                    mapView.addAnnotations(annotations)
                    // 
                    // let annotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
                    // let distance = catLocation.distance(from: annotationLocation)
                    
                    // print("++> distance: \(distance)")
                    
                    // let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    // 
                    // if distance <= 3000 { // 3km 이내에 있는 마커만 추가
                    //     annotationsInCircle.append(annotation)
                    //     print("++> distance <= 3000 결과값: \(annotationsInCircle) ")
                    // }
             
                    
                    // 지도의 영역을 마커의 위치로 설정
                    // if let annotation = mapView.annotations.first {
                    //     let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    //     mapView.setRegion(region, animated: true)
                    // }
                    
                    
                    // 지도의 영역을 마커의 위치로 설정
                    // if let annotation = annotationsInCircle.first {
                    //     let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    //     mapView.setRegion(region, animated: true)
                    // }
                    // 현재 위치로 지도 이동
                    // mapView.setRegion(MKCoordinateRegion(center: catLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true)
                    
                    // annotations.append(annotation)
                    
                    // mapView.setRegion(region, animated: true)
                    // uiView을 MKMapView로 캐스팅
                    print("화면 이동이 종료 markers  annotation.coordinate : \(annotation.coordinate.latitude),annotation.coordinate : \(annotation.coordinate.longitude) ")
                }
            }
            
            // 지도에 마커 표시
            // for annotation in annotations {
            //     mapView.addAnnotation(annotation)
            // }
            //
            
            
        } catch {
            print("Error loading data from Realm: \(error)")
        }
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
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            // handle error
        }
    }
}
