//
//  CareCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/08.
//

import SwiftUI
import MapKit
import RealmSwift

struct CareCatView: View {
    @Binding var presentSideMenu: Bool //네비게이션바아이템
    
    @State private var isShowingModal = false
    @EnvironmentObject var locationManager: AddressManager
    @EnvironmentObject var model: Model
    @State private var selectedColor = 0 // 초기 선택 색상 인덱스
    @EnvironmentObject var eventAddViewModel: EventAddViewModel
    
    
    // Model 클래스의 인스턴스를 생성
    var body: some View {
    
        NavigationView{
            VStack {
                MapViewCoordinator(locationManager: locationManager, eventAddViewModel: eventAddViewModel)
                    .frame(height: UIScreen.main.bounds.height / 2)
                
                Button(action: {
                    isShowingModal.toggle() // 버튼을 탭하면 모달을 열기/닫기
                }) {
                    Text("Add Event")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $isShowingModal) {
                    // 모달이 표시되면 addEvent 뷰가 열립니다.
                    AddEventView(model: eventAddViewModel)
                }
            }
            .onAppear {
                eventAddViewModel.loadAnnotationsFromRealm()
            }
            .navigationBarItems(leading: Text("주변돌봄"),
                trailing: NavigationMenuView(presentSideMenu: $presentSideMenu))
        }
    }
}

struct MapViewCoordinator: UIViewRepresentable {
    
    @ObservedObject var locationManager: AddressManager
    @State private var annotations: [MKPointAnnotation] = []
    @ObservedObject var eventAddViewModel:EventAddViewModel
    // @ObservedObject var mkAnnotation: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> some UIView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        // uiView.removeAnnotation(uiView.annotations)
        let markers = eventAddViewModel.annotations
        
        print("markers : \(markers)")
        for marker in markers {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: marker.coordinate.latitude, longitude: marker.coordinate.longitude)
            annotation.title = marker.title
            
            if let mapView = uiView as? MKMapView {
                
                let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                mapView.addAnnotation(annotation)
                mapView.setRegion(region, animated: true)
            }
            // uiView을 MKMapView로 캐스팅
            print("markers  annotation.coordinate : \(marker.coordinate.latitude),annotation.coordinate : \(marker.coordinate.longitude) ")
        }

        // 위도경도 업데이트
          if let mapView = uiView as? MKMapView {
            
          }
    }
}

// #Preview {
//     CareCatView(presentSideMenu: PRESENT_SIDE_MENU)
// }
