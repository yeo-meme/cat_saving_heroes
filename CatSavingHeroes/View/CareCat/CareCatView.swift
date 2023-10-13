//
//  CareCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/08.
//

import SwiftUI

struct CareCatView: View {
    
    @State private var isShowingModal = false
    @EnvironmentObject var locationManager: AddressManager
    @EnvironmentObject var model: Model
    @State private var selectedColor = 0 // 초기 선택 색상 인덱스
    @EnvironmentObject var eventAddViewModel: EventAddViewModel
    
    
    // Model 클래스의 인스턴스를 생성
    var body: some View {
        VStack {
            MapViewCoordinator(locationManager: locationManager)
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
        .padding()
    }
}

struct MapViewCoordinator: UIViewRepresentable {
    @ObservedObject var locationManager: AddressManager
    
    func makeUIView(context: Context) -> some UIView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

#Preview {
    CareCatView()
}
