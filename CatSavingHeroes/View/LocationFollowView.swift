//
//  LocationView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI
import MapKit
import CoreLocation


struct LocationFollowView: View {
    @StateObject var model = Model()
      
    var body: some View {
      VStack(alignment: .center, spacing: 20) {
        Text("Location Tracker")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding(EdgeInsets(top: 50, leading: 50, bottom: 0, trailing: 50))

        Button(
          action: { model.startStopLocationTracking() },
          label: {
            VStack {
              Image(systemName: model.isLocationTrackingEnabled ? "stop" : "location")
              Text(model.isLocationTrackingEnabled ? "Stop" : "Start")
            }
          })
        .font(.title)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))

        Map(coordinateRegion: $model.region, annotationItems: model.pins) { pin in
          MapPin(coordinate: pin.coordinate, tint: .red)
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
      }
    }
    }

extension LocationFollowView {
  class Model: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var isLocationTrackingEnabled = false
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
      span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Published var pins: [PinLocation] = []

    let mgr: CLLocationManager

    override init() {
      mgr = CLLocationManager()
      mgr.desiredAccuracy = kCLLocationAccuracyBest
      mgr.requestAlwaysAuthorization()
      mgr.allowsBackgroundLocationUpdates = true

      super.init()
      mgr.delegate = self
    }

    func enable() {
      mgr.startUpdatingLocation()
    }

    func disable() {
      mgr.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      if let currentLocation = locations.first {
        print(currentLocation)
        location = currentLocation
        appendPin(location: currentLocation)
        updateRegion(location: currentLocation)
      }
    }

    func appendPin(location: CLLocation) {
      pins.append(PinLocation(coordinate: location.coordinate))
    }

    func updateRegion(location: CLLocation) {
      region = MKCoordinateRegion(
        center: location.coordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
    }

    func startStopLocationTracking() {
      isLocationTrackingEnabled.toggle()
      if isLocationTrackingEnabled {
        enable()
      } else {
        disable()
      }
    }
  }

  struct PinLocation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
  }
}
