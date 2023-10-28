//
//  TrackingHeroViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import Combine
import CoreLocation
import MapKit
import RealmSwift
import SwiftUI


extension TrackingHeroView {
    
    // func saveLocationToRealm() {
    //     // 위치 정보를 사용하여 LocationRecord 객체 생성
    //     let locationRecord = LocationRecord()
    //     // locationRecord.latitude = lastLocation.latitude
    //     // locationRecord.longitude = lastLocation.longitude
    //
    //     // Realm에 위치 정보 저장
    //     do {
    //         let realm = try Realm()
    //         try realm.write {
    //             realm.add(locationRecord)
    //         }
    //         print("Location saved to Realm")
    //     } catch {
    //         print("Error saving location to Realm: \(error.localizedDescription)")
    //     }
    // }
    
    struct PinLocation: Identifiable {
        let id = UUID()
        var coordinate: CLLocationCoordinate2D
    }
}

//영웅 트래킹
class Model: NSObject, CLLocationManagerDelegate, ObservableObject, MKMapViewDelegate {
    
    @Published var isLocationTrackingEnabled = false
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion( //지도 초기값
        //남산 : latitude: 37.558890, longitude: 126.982230
        center: CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    @Published var pins: [PinLocation] = []
    @Published var coordinates: [CLLocationCoordinate2D] = []
    var mgr : CLLocationManager = .init()
    
    @Published var lastLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    private var locationManager = CLLocationManager()
    
    @Binding var userLocation: CLLocationCoordinate2D?
    @Binding var locations: [CLLocationCoordinate2D]
    
    
    //현위치 표시
    @Published var mapView: MKMapView = .init()
    private var manager: CLLocationManager = .init()
    @Published var mainUpdateResion:MKCoordinateRegion?
    var previousLocation: CLLocation?
    
    // 인스턴스를 공유하기 위한 프로퍼티 추가 addEventModel에서
    //isLocationTrackingEnabled 값을 읽기 위해 인스턴스 공유하도록 설정
    // static let shared = Model(userLocation: .constant(nil), locations: .constant([]))
    
    
    init(userLocation: Binding<CLLocationCoordinate2D?>, locations: Binding<[CLLocationCoordinate2D]>) {
        // mgr = CLLocationManager()  // Initialize mgr here before calling
        
        _userLocation = userLocation
        _locations = locations
        
        
        mgr = CLLocationManager()
        mgr.requestWhenInUseAuthorization()
        mgr.desiredAccuracy = kCLLocationAccuracyBest
        mgr.allowsBackgroundLocationUpdates = true
        super.init()
        mgr.delegate = self
        
        
    }
    
  
    
    
    // MARK: - 사용자의 현재 위치로 MapView를 이동하는 메서드
    func moveFocusOnUserLocation() {
        mapView.delegate = self
        manager.delegate = self
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        if let location = mgr.location {
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
        // self.addMyLocationMarker()
    }
    
    // static let shared = Model(userLocation: self.$userLocation, locations: self.$locations)
    
    // override init() {
    //
    //     // _userLocation = userLocation
    //     // _locations = locations
    //
    //     mgr = CLLocationManager()
    //     mgr.requestWhenInUseAuthorization()
    //     mgr.desiredAccuracy = kCLLocationAccuracyBest
    //     mgr.allowsBackgroundLocationUpdates = true
    //     super.init()
    //     mgr.delegate = self
    //
    // }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func startUpdatingLocation() {
        mgr.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        mgr.stopUpdatingLocation()
    }
    
    //맵 처음 로드 될 떄
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //pin data
        if let currentLocation = locations.first{
            print(currentLocation)
            location = currentLocation
            appendPin(location: currentLocation)
            updateRegion(location: currentLocation)
            coordinates = locations.map { $0.coordinate }
            // distanceTraveled(currentLocation)
            
            
            realmMigration()
            
            // 실시간 업데이트
            let tracking = createTrackingObject(location: currentLocation)
            
            // Realm 객체 생성
            // let tracking = Tracking()
            //
            // // Tracking 객체의 속성 설정
            // // tracking.id = ObjectId()
            // tracking.arrival_time = Date().description
            // tracking.departure_time = Date().description
            // tracking.departure_point = currentLocation.coordinate.latitude.description + ", " + currentLocation.coordinate.longitude.description
            // tracking.destination_point = ""
            // tracking.track_time = ""
            // tracking.route = ""
            // tracking.distance = ""
            // tracking.timestamp = Date().description
            // tracking.user = ""
            // tracking.arrival_address = currentLocation.coordinate.latitude.description + ", " + currentLocation.coordinate.longitude.description
            // tracking.departure_address = "departureAddress"
            // tracking.event_coodinate = "eventCoordinate"
            // tracking.event_time = "eventTime"
            // tracking.event_address = "eventAddress"
            // tracking.event_cat = "eventCat"
            // // Realm 객체에 Tracking 객체 저장
            
        
        }
        
        
        
        //Realm data 주소 업로드 관련 객체 ㄱ
        if let newLocation = locations.last?.coordinate {
            lastLocation = newLocation
            print("new Location:\(lastLocation)")
        }
        
        if let location = locations.last?.coordinate {
            self.userLocation = location
            self.locations.append(location)
        }
        
        guard let addressLct = locations.first else {
            return
        }
        
        guard let resentLocation = locations.first else {
            return
        }
        
        if let previousLocation = previousLocation {
            // 이전 위치와 현재 위치 간의 거리 계산
            let distance = previousLocation.distance(from: resentLocation)
            print("이동한 거리: \(distance) 미터")
        }
        //이동한 거리
        previousLocation = location
        
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(addressLct) { (placemarks, error) in
            if let error = error {
                print("주소를 가져오는 중 오류 발생: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                // 주소 정보는 placemark에 있습니다.
                if let address = placemark.name,
                   let city = placemark.locality,
                   let state = placemark.administrativeArea,
                   let postalCode = placemark.postalCode,
                   let country = placemark.country {
                    print("주소: \(address), \(city), \(state) \(postalCode), \(country)")
                }
            }
        }
    }
    
    func createTrackingObject(location: CLLocation){
        let tracking = Tracking()
        
        // Tracking 객체의 속성 설정
        tracking.arrival_time = Date().description
        tracking.departure_time = Date().description
        tracking.departure_point = location.coordinate.latitude.description + ", " + location.coordinate.longitude.description
        tracking.destination_point = ""
        tracking.track_time = ""
        tracking.route = location.coordinate.latitude.description
        tracking.distance = ""
        tracking.timestamp = Date().description
        tracking.user = ""
        tracking.arrival_address = location.coordinate.latitude.description + ", " + location.coordinate.longitude.description
        tracking.departure_address = "departureAddress"
        tracking.event_latitude = 0.0
        tracking.event_longitude = 0.0
        tracking.event_time = "eventTime"
        tracking.event_address = "eventAddress"
        tracking.event_cat = "eventCat"
        
        RealmHelper.shared.create(tracking)
        let track =  RealmHelper.shared.read(Tracking.self)
        
        
        for aaa in track {
            print("실시간 업데이트 트랙킹 저장한값 : \(aaa.route)")
        }
    }
    
    
    
    func addressConverter(location: CLLocation){
        
    }
    
    //이동한 거리
    //TODO: 함수로 뺴기
    func distanceTraveled(location: CLLocation) {
        
        
    }
    func appendPin(location: CLLocation) {
        pins.append(PinLocation( coordinate: location.coordinate))
        print("뉴 경로:\(pins)")
    }
    
   
    
    func moveFocusOnUserLocation2() {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
        if let location = mgr.location {
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mainUpdateResion = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
          
            let circle = MKCircle(center: location.coordinate, radius: 3000)
            mapView.addOverlay(circle)
            
        } else {
            // 사용자의 위치가 아직 가져오지 못했다면, 대한민국 남산으로 지도의 위치를 표시
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let defaultLocation = CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880) // 기본 위치
            let region = MKCoordinateRegion(center: defaultLocation, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func updateRegion(location: CLLocation) {
        region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
    }
    
    func startStopLocationTracking() {
        isLocationTrackingEnabled.toggle()
        if isLocationTrackingEnabled {
            startUpdatingLocation()
            print("where : Model in isLocationTrackingEnabled in start: \(isLocationTrackingEnabled)")
            insertLocationUserDefaults(state: true)
        } else {
            stopUpdatingLocation()
            print("where : Model in isLocationTrackingEnabled state stop start: \(isLocationTrackingEnabled)")
            insertLocationUserDefaults(state: false)
        }
    }
    

    
    //UserDefaults 값 저장 트래킹 백그라운드 상태
    func insertLocationUserDefaults(state:Bool) {
        
        let defaults = UserDefaults.standard
        let isLocationTrackingEnabled = state
        
        // 기존 값 가져오기
        let existingValue = defaults.object(forKey: "isLocationTrackingEnabled") as? NSNumber
        
        if existingValue != nil {
            defaults.set(isLocationTrackingEnabled, forKey: "isLocationTrackingEnabled")
        } else {
            // 기존 값이 존재하지 않는 경우
            // 불리언 값을 NSNumber로 변환하여 UserDefaults에 저장
            let defaults = UserDefaults.standard
            defaults.set(NSNumber(value: isLocationTrackingEnabled), forKey: "isLocationTrackingEnabled")
        }
    }
}


struct PinLocation: Identifiable {
    
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

class LocationRecord: Object {
    @Persisted var latitude: Double = 0.0
    @Persisted var longitude: Double = 0.0
    @Persisted var timestamp: Date = Date()
}
