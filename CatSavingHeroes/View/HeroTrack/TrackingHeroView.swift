//
//  TrackingHeroView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import SwiftUI
import CoreLocation
import MapKit

struct TrackingHeroView: View {
    @StateObject var model = Model()
      @State private var coordinates: [CLLocationCoordinate2D] = []
      
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

#Preview {
    TrackingHeroView()
}
