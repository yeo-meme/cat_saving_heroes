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
    @State private var isRecording = false
    
    @State private var coordinates: [CLLocationCoordinate2D] = []
    @State private var isShowingModal = false
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            ZStack {
                Map(coordinateRegion: $model.region, annotationItems: model.pins) { pin in
                    MapPin(coordinate: pin.coordinate, tint: .red)
                }
                
                Spacer()
                
                Button(action: {
                    model.startStopLocationTracking()
                    
                    // isRecording.toggle()
                    // 
                    // if isRecording {
                    //     model.startUpdatingLocation()
                    // } else {
                    //     model.stopUpdatingLocation()
                    //     // 위치 기록을 Realm에 저장
                    //     let locationRecord = LocationRecord()
                    //     locationRecord.latitude = self.model.lastLocation.latitude // 수정된 부분
                    //     locationRecord.longitude = self.model.lastLocation.longitude // 수정된 부분
                    // }
                }) {
                    Text(model.isLocationTrackingEnabled ? "기록중지" : "기록시작")
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Capsule()
                                .fill(Color.purple)
                        )
                }
            }
            
            VStack {
                
                Button("Show Bottom Sheet") {
                    isShowingModal.toggle()
                }
            }
            .sheet(isPresented: $isShowingModal, content: {
                BottomSheetModalView(isShowingModal: $isShowingModal)
            })
        }
    }
}

struct BottomSheetModalView: View {
    @Binding var isShowingModal: Bool
    
    var body: some View {
        VStack {
            Text("Bottom Sheet Content")
                .font(.title)
                .padding()
            
            Button("Close") {
                isShowingModal.toggle()
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .padding()
        .shadow(radius: 5)
        .edgesIgnoringSafeArea(.bottom)
    }
}

// #Preview {
//     TrackingHeroView()
// }
