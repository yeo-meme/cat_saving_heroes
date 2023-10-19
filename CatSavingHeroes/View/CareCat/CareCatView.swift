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
    @State private var selectedNumber = 1
    private let numbers = [1,2,3,4,5]
    
    
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
                VStack{
                    HStack{
                        Picker("반경선택", selection: $selectedNumber) {
                            ForEach(numbers, id: \.self) { number in
                                Text("\(number)")
                                    .foregroundColor(.purple)
                            }
                        }
                            .pickerStyle(MenuPickerStyle())
                            .cornerRadius(15)
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.purple, lineWidth: 1)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Text("반경 \(selectedNumber)km이내 고양이들")
                            .font(.system(size: 15, weight: .bold, design: .default))
                    }
                       
                    MapViewCoordinator(locationManager: locationManager, eventAddViewModel: eventAddViewModel)
                        .frame(height: 300)
                }
                
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.clear)
                    .cornerRadius(20)
                
                // 그림자 효과
                    .shadow(color: .gray, radius: 20)
                
                // DropdownButton()
                VStack{
                    OvalButton(text: "주변냥")
                }.shadow(color: .black, radius: 10, x: 10, y: 10)
                
                
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
            // .background(Color.red)
            .onAppear {
                
                // callRealm()
                // eventAddViewModel.loadAnnotationsFromRealm()
            }
            .navigationBarItems(leading: Text("주변돌봄"),
                                trailing: NavigationMenuView(presentSideMenu: $presentSideMenu))
            // .background(Color.gray)
            
        }.background(Color.blue)
    }
    
    
    // func callRealm() {
    //     // 트랙킹 Realm 객체를 읽습니다.
    //     let trackingEvents = RealmHelper.shared.read(Tracking.self)
    //
    //     //TODO : 저장된값중에 0.0 이 아닌값만 출력하기 test 중
    //     // latitude와 longitude 값이 0.0이 아닌 값만 필터링합니다.
    //     for trackingEvent in trackingEvents {
    //         if Double(trackingEvent.event_latitude) != 0.0{
    //             print("이벤트 캣 : \(trackingEvent.event_latitude)" )
    //         } else {
    //             print("이벤트 캣 0.0: \(trackingEvent.event_latitude)" )
    //         }
    //     }
    // }
}


struct MapViewCoordinator: UIViewRepresentable {
    
    @ObservedObject var locationManager: AddressManager
    @State private var annotations: [MKPointAnnotation] = []
    @ObservedObject var eventAddViewModel:EventAddViewModel
    // @ObservedObject var mkAnnotation: [MKPointAnnotation]
    
    func makeUIView(context: Context) -> some UIView {
        print("MapViewCoordinator 맵을 그리는 시작")
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        // uiView.removeAnnotation(uiView.annotations)
        
        // TODO: - 로드할때 한번만 호출하기
        // let markers = eventAddViewModel.annotations
        //
        // print("markers : \(markers)")
        // for marker in markers {
        //     let annotation = MKPointAnnotation()
        //     annotation.coordinate = CLLocationCoordinate2D(latitude: marker.coordinate.latitude, longitude: marker.coordinate.longitude)
        //     annotation.title = marker.title
        //
        //     if let mapView = uiView as? MKMapView {
        //
        //         let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        //         mapView.addAnnotation(annotation)
        //         mapView.setRegion(region, animated: true)
        //     }
        //     // uiView을 MKMapView로 캐스팅
        //     print("markers  annotation.coordinate : \(marker.coordinate.latitude),annotation.coordinate : \(marker.coordinate.longitude) ")
        // }
        //
        // // 위도경도 업데이트
        //   if let mapView = uiView as? MKMapView {
        //
        //   }
    }
}

// #Preview {
//     CareCatView(presentSideMenu: Binding.constant(false))
// }
