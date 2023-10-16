//
//  LocationView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI
import MapKit
import CoreLocation
import SlidingTabView


struct LocationFollowView: View {
    
    @Binding var presentSideMenu: Bool
    
    @State private var tabIndex = 0
    var body: some View {
        
        
        NavigationView{
            VStack{
                SlidingTabView(selection: $tabIndex, tabs: ["영웅업무시작","영웅일지"], selectionBarColor: .green)
                
                Spacer()
                
                if tabIndex == 0 {
                    TrackingHeroView()
                    
                } else if tabIndex == 1 {
                    HeroCalendarView()
                }
                
                Spacer()
            }
            .navigationBarItems(leading: Text("영웅일지"),
                trailing: NavigationMenuView(presentSideMenu: $presentSideMenu))
            // .navigationTitle("영웅일지")
        }
        
    }
}

// extension LocationFollowView {
//     class Model: NSObject, CLLocationManagerDelegate, ObservableObject {
//         @Published var isLocationTrackingEnabled = false
//         @Published var location: CLLocation?
//         @Published var region = MKCoordinateRegion(
//             center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
//             span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//         @Published var pins: [PinLocation] = []
//         
//         let mgr: CLLocationManager
//         
//         override init() {
//             mgr = CLLocationManager()
//             mgr.desiredAccuracy = kCLLocationAccuracyBest
//             mgr.requestAlwaysAuthorization()
//             mgr.allowsBackgroundLocationUpdates = true
//             
//             super.init()
//             mgr.delegate = self
//         }
//         
//         func enable() {
//             mgr.startUpdatingLocation()
//         }
//         
//         func disable() {
//             mgr.stopUpdatingLocation()
//         }
//         
//         func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//             if let currentLocation = locations.first {
//                 print(currentLocation)
//                 location = currentLocation
//                 appendPin(location: currentLocation)
//                 updateRegion(location: currentLocation)
//             }
//         }
//         
//         func appendPin(location: CLLocation) {
//             pins.append(PinLocation(coordinate: location.coordinate))
//         }
//         
//         func updateRegion(location: CLLocation) {
//             region = MKCoordinateRegion(
//                 center: location.coordinate,
//                 span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
//         }
//         
//         func startStopLocationTracking() {
//             isLocationTrackingEnabled.toggle()
//             if isLocationTrackingEnabled {
//                 enable()
//             } else {
//                 disable()
//             }
//         }
//     }
//     
//     struct PinLocation: Identifiable {
//         let id = UUID()
//         var coordinate: CLLocationCoordinate2D
//     }
// }
