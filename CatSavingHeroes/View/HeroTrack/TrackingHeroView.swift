//
//  TrackingHeroView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapView: UIViewRepresentable {
    @State private var coordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 37.544251, longitude: 127.037049),
        CLLocationCoordinate2D(latitude: 37.544358, longitude: 127.037482),
        CLLocationCoordinate2D(latitude: 37.544679, longitude: 127.037361),
        CLLocationCoordinate2D(latitude: 37.544913, longitude: 127.037326),
        CLLocationCoordinate2D(latitude: 37.545237, longitude: 127.037369),
        CLLocationCoordinate2D(latitude: 37.545445, longitude: 127.037456),
        CLLocationCoordinate2D(latitude: 37.545571, longitude: 127.037542),
        CLLocationCoordinate2D(latitude: 37.545747, longitude: 127.037715),
        CLLocationCoordinate2D(latitude: 37.545919, longitude: 127.037955),
        CLLocationCoordinate2D(latitude: 37.545946, longitude: 127.037993),
        CLLocationCoordinate2D(latitude: 37.545902, longitude: 127.03816),
        CLLocationCoordinate2D(latitude: 37.54586, longitude: 127.038347),
        CLLocationCoordinate2D(latitude: 37.545794, longitude: 127.038583),
        CLLocationCoordinate2D(latitude: 37.545731, longitude: 127.038804),
        CLLocationCoordinate2D(latitude: 37.545657, longitude: 127.039083),
        CLLocationCoordinate2D(latitude: 37.54572, longitude: 127.039231),
        CLLocationCoordinate2D(latitude: 37.545739, longitude: 127.03932),
        CLLocationCoordinate2D(latitude: 37.545743, longitude: 127.039371),
        CLLocationCoordinate2D(latitude: 37.545749, longitude: 127.039456),
        CLLocationCoordinate2D(latitude: 37.545729, longitude: 127.039631),
        CLLocationCoordinate2D(latitude: 37.545639, longitude: 127.039944),
        CLLocationCoordinate2D(latitude: 37.545555, longitude: 127.040074),
        CLLocationCoordinate2D(latitude: 37.545516, longitude: 127.040192),
        CLLocationCoordinate2D(latitude: 37.54552, longitude: 127.0403),
        CLLocationCoordinate2D(latitude: 37.54559, longitude: 127.040426),
        CLLocationCoordinate2D(latitude: 37.54561, longitude: 127.040491),
        CLLocationCoordinate2D(latitude: 37.544985, longitude: 127.040224),
        CLLocationCoordinate2D(latitude: 37.544848, longitude: 127.040166),
        CLLocationCoordinate2D(latitude: 37.544381, longitude: 127.039937),
        CLLocationCoordinate2D(latitude: 37.544327, longitude: 127.039727),
        CLLocationCoordinate2D(latitude: 37.544306, longitude: 127.03956),
        CLLocationCoordinate2D(latitude: 37.544205, longitude: 127.039262),
        CLLocationCoordinate2D(latitude: 37.544153, longitude: 127.03915),
        CLLocationCoordinate2D(latitude: 37.544078, longitude: 127.039095),
        CLLocationCoordinate2D(latitude: 37.54404, longitude: 127.03906),
        CLLocationCoordinate2D(latitude: 37.543981, longitude: 127.038979),
        CLLocationCoordinate2D(latitude: 37.543961, longitude: 127.03888),
        CLLocationCoordinate2D(latitude: 37.543949, longitude: 127.038822),
        CLLocationCoordinate2D(latitude: 37.544011, longitude: 127.038448)
    ]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        uiView.addOverlay(polyline)
        
        if !coordinates.isEmpty {
            let region = MKCoordinateRegion(
                center: coordinates.first!,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
            uiView.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = .blue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

struct TrackingHeroView: View {
    // @StateObject private var model = Model()
    @EnvironmentObject var model: Model
    @ObservedObject var weatherModel: WeatherViewModel
    @State private var isRecording = false
    
    @State private var coordinates: [CLLocationCoordinate2D] = []
    @State private var isShowingModal = false
    
    var body: some View {
        VStack {
            MapView().frame(height: 300)

            bottomInfo

            goToRecordViewButton
        }
    }

   var bottomInfo: some View {
        ScrollView {
            bottomItem(label:"시작시간",sysImg: "clock", message:"08:12 AM")
            bottomItem(label:"종료시간",sysImg: "stopwatch", message:"10:23 AM")
            bottomItem(label:"이동거리",sysImg: "figure.walk", message:"3.2 km")
            bottomItem(label:"경과시간",sysImg: "hourglass", message:"2시간 11분")
            bottomItem(label:"활동장소",sysImg: "location", message:"서울숲")
        }
        .padding()
   }

    func bottomItem(label: String, sysImg: String, message: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 10) {
            Label(label, systemImage: sysImg) // 제목을 나타내는 Label
                .font(.headline)
                
            Text(message) // 내용을 나타내는 Text
                .font(.body)
            
            Spacer()
        }
        .padding(10)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
   }

    var goToRecordViewButton: some View {
        Button(action: {
            model.startStopLocationTracking()
        }) {
            HStack(alignment: .center){
                Spacer()
                Image(systemName: "waveform.path.badge.plus")
                    .foregroundColor(.white)
                    .padding(.leading, 5)
                
                Text(model.isLocationTrackingEnabled ? "기록중지" : "기록시작")
                    .background(model.isLocationTrackingEnabled ? Color.complementColor : Color.primaryColor)
                    .foregroundColor(.white)
                    .frame(width: 70, height: 36)
                Spacer()
            }
            .background(
                Capsule()
                    .fill(Color.primaryColor)
            )
        }.padding()
    }
}
