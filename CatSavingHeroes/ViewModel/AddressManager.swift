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

            // 대한민국 남산으로 지도의 위치를 표시 latitude: 37.5514, longitude: 126.9880
                   let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            
                   let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880), span: span)
                   mapView.setRegion(region, animated: true)
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
        loadAnnotationsFromRealm()
        
        //고양이 로드
        let filteredTrackingEvents = getEventCoodinateRealm()
        
        
        // 현재 위치
        let catLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        // 반경 3km 이내 마커
        let circle = MKCircle(center: catLocation.coordinate, radius: 3000)
        
        
        
        // 지도에 마커 표시
        for filteredTrackingEvent in filteredTrackingEvents {
            if Double(filteredTrackingEvent.event_latitude) != 0.0 {
                mapView.addAnnotation(filteredTrackingEvent as! MKAnnotation)
            }
        }
        
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
    
    func getEventCoodinateRealm() -> [Tracking]  {
        // 트랙킹 Realm 객체를 읽습니다.
        let trackingEvents = RealmHelper.shared.read(Tracking.self)
        
        //TODO : 저장된값중에 0.0 이 아닌값만 출력하기 test 중
        // latitude와 longitude 값이 0.0이 아닌 값만 필터링합니다.
        var filteredTrackingEvents = [Tracking]()
        
        for trackingEvent in trackingEvents {
            if Double(trackingEvent.event_latitude) != 0.0{
                print("이벤트 캣 : \(trackingEvent.event_latitude)" )
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
    
    //고양이 이벤트 표시 realm 호출
    func loadAnnotationsFromRealm() {
        do {
            // 현재 위치
            let catLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            
            // deleteAll()
            
            let realm = try Realm()
            let careModels = realm.objects(CareRealmModel.self)
            for careModel in careModels {
                if careModel.latitude != 0.0 && careModel.longitude != 0.0 {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: careModel.latitude, longitude: careModel.longitude)
                    
                    let annotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
                    let distance = catLocation.distance(from: annotationLocation)
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    
                    if distance <= 3000 { // 3km 이내에 있는 마커만 추가
                        annotationsInCircle.append(annotation)
                    }
                    
                    // 지도에 마커 표시
                    mapView.addAnnotations(annotationsInCircle)
                    
                    // 지도의 영역을 마커의 위치로 설정
                    if let annotation = annotationsInCircle.first {
                        let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                        mapView.setRegion(region, animated: true)
                    }
                    
                    
                    // annotations.append(annotation)
                    
                    // mapView.setRegion(region, animated: true)
                    // uiView을 MKMapView로 캐스팅
                    print("화면 이동이 종료 markers  annotation.coordinate : \(annotation.coordinate.latitude),annotation.coordinate : \(annotation.coordinate.longitude) ")
                }
            }
            
            // 지도에 마커 표시
            for annotation in annotations {
                mapView.addAnnotation(annotation)
            }
            
            // 지도의 영역을 마커의 위치로 설정
            if let annotation = annotations.first {
                let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                mapView.setRegion(region, animated: true)
            }
            
            
        } catch {
            print("Error loading data from Realm: \(error)")
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
