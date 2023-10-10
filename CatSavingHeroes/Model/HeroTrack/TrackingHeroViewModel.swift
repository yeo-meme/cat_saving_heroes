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
    class Model: NSObject, CLLocationManagerDelegate, ObservableObject {
        @Published var isLocationTrackingEnabled = false
        @Published var location: CLLocation?
        @Published var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        @Published var pins: [PinLocation] = []
        @Published var coordinates: [CLLocationCoordinate2D] = []
        var mgr : CLLocationManager
        
        @Published var lastLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
        private var locationManager = CLLocationManager()
        
        @Binding var userLocation: CLLocationCoordinate2D?
        @Binding var locations: [CLLocationCoordinate2D]
        
        
        init(userLocation: Binding<CLLocationCoordinate2D?>, locations: Binding<[CLLocationCoordinate2D]>) {
            mgr = CLLocationManager()  // Initialize mgr here before calling
            
            _userLocation = userLocation
            _locations = locations
        
            
            mgr = CLLocationManager()
            mgr.requestWhenInUseAuthorization()
            mgr.desiredAccuracy = kCLLocationAccuracyBest
            mgr.allowsBackgroundLocationUpdates = true
            super.init()
            mgr.delegate = self
            
        }
        
        func startUpdatingLocation() {
            mgr.startUpdatingLocation()
        }
        
        func stopUpdatingLocation() {
            mgr.stopUpdatingLocation()
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let currentLocation = locations.first {
                print(currentLocation)
                location = currentLocation
                appendPin(location: currentLocation)
                updateRegion(location: currentLocation)
                coordinates = locations.map { $0.coordinate }
            }
            // if let newLocation = locations.last?.coordinate {
            //     lastLocation = newLocation
            //     print("new Location:\(lastLocation)")
            //
            // }
            // if let location = locations.last?.coordinate {
            //     self.userLocation = location
            //     self.locations.append(location)
            // }
        }
        
        func appendPin(location: CLLocation) {
            pins.append(PinLocation(coordinate: location.coordinate))
            print("뉴 경로:\(pins)")
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
                print("in start")
            } else {
                stopUpdatingLocation()
                print("stop start")
            }
        }
    }
    
    
    func saveLocationToRealm() {
        // 위치 정보를 사용하여 LocationRecord 객체 생성
        let locationRecord = LocationRecord()
        // locationRecord.latitude = lastLocation.latitude
        // locationRecord.longitude = lastLocation.longitude
        
        // Realm에 위치 정보 저장
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(locationRecord)
            }
            print("Location saved to Realm")
        } catch {
            print("Error saving location to Realm: \(error.localizedDescription)")
        }
    }
    
    struct PinLocation: Identifiable {
        let id = UUID()
        var coordinate: CLLocationCoordinate2D
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
