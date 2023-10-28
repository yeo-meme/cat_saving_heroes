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
    // @StateObject private var model = Model()
    @EnvironmentObject var model: Model
    @ObservedObject var weatherModel: WeatherViewModel
    @State private var isRecording = false
    
    @State private var coordinates: [CLLocationCoordinate2D] = []
    @State private var isShowingModal = false
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 1) {
         
            ZStack {
                HStack {
                    Button(action: {
                        model.moveFocusOnUserLocation2()
                    }, label: {
                        HStack{
                            Image(systemName: "location.viewfinder")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.leading)
                                .clipShape(Circle())
                             Text("현위치")
                        }
                    })
                   
                    }
                    .zIndex(1)
                    .position(x: 0, y: 0)
                   
                
                Group{
                    Map(coordinateRegion: $model.region, annotationItems: model.pins) { pin in
                        MapPin(coordinate: pin.coordinate, tint: .red)
                        // for route in model.pins {
                        //     MapPolyline(coordinates: route)
                        // }
                    }}
                .padding(.top , 15)
                Spacer()
                
                
                VStack{
                    Spacer()
                    Button(action: {
                        model.startStopLocationTracking()
                    }) {
                        Text(model.isLocationTrackingEnabled ? "기록중지" : "기록시작")
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Capsule()
                                    .fill(Color.purple)
                            )
                    }.padding(.bottom, 10)
                }
            }
            
            // VStack {
            //     
            //     Button("Show Bottom Sheet") {
            //         isShowingModal.toggle()
            //     }
            // }
            // .sheet(isPresented: $isShowingModal, content: {
            //     BottomSheetModalView(isShowingModal: $isShowingModal)
            // })
        }
        
    }
}

// struct BottomSheetModalView: View {
//     @Binding var isShowingModal: Bool
//     
//     var body: some View {
//         VStack {
//             Text("Bottom Sheet Content")
//                 .font(.title)
//                 .padding()
//             
//             Button("Close") {
//                 isShowingModal.toggle()
//             }
//         }
//         .frame(maxWidth: .infinity)
//         .background(Color.white)
//         .cornerRadius(10)
//         .padding()
//         .shadow(radius: 5)
//         .edgesIgnoringSafeArea(.bottom)
//     }
// }

// #Preview {
//     TrackingHeroView()
// }
