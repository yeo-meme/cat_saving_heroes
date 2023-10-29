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
    
    var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    let rowSpacing: CGFloat = 10
    
    //네비게이션아이템
    @State var presentNavigationBar: Bool=false //네비게이션바아이템
    @Binding var presentSideMenu: Bool //네비게이션바아이템
    
    
    @State private var isShowingSideMenu = false //side
    @State var selectedSideMenuTab = 0//side
    
    @State private var isShowingModal = false
    
    @EnvironmentObject var locationManager: AddressManager
    @EnvironmentObject var model: Model
    @State private var selectedColor = 0 // 초기 선택 색상 인덱스
    @EnvironmentObject var eventAddViewModel: EventAddViewModel
    @ObservedObject var strayModel = StrayCatsALLViewModel()
    
    //데이터 추가 로드시 8개씩
    @State private var strayCatList: [Cats] = [] // 전체 데이터 배열
    @State private var visibleCount = 8 // 현재 표시 중인 아이템 수
    // @Binding var presentSideMenu: Bool
    
    
    
    // Model 클래스의 인스턴스를 생성
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                VStack{
                    MapViewCoordinator(locationManager: locationManager, eventAddViewModel: eventAddViewModel)
                        .frame(height: 300)
                    
                    // Spacer()
                    // CategoryItemView(isShowingModal: $isShowingModal)
                    VStack(alignment: .leading, spacing: 6){
                        if let strayCatList = strayModel.arrAllCatsList {
                            ScrollView(.vertical, showsIndicators: false) {
                                HStack{
                                    ForEach(strayCatList) { strayCat in
                                        VStack{
                                            StrayCatsItemView(viewModel: StrayCatsItemViewModel(strayCat))
                                                .frame(width: 150)
                                        }
                                        //     ConversationCell(viewModel: ConversationCellViewModel(message))
                                        // VStack{
                                        //     LazyVGrid(columns: gridLayout, spacing: 15, content: {
                                        //         StrayCatsItemView(viewModel: StrayCatsItemViewModel(strayCat))
                                        //     }
                                        //     )}
                                        
                                    }
                                }
                                
                                // if visibleCount < strayCatList.count {
                                //     Button("더 보기") {
                                //         visibleCount += 8 // 다음 8개 아이템을 표시
                                //         if visibleCount > strayCatList.count {
                                //             visibleCount = strayCatList.count // 끝까지 도달하면 모든 아이템을 표시
                                //         }
                                //     }
                                // }
                            }
                        } else {
                            Text("이벤트등록된 고양이가 없네요")
                            Spacer()
                        }
                    } //List
                    .sheet(isPresented: $isShowingModal) {
                        // 모달이 표시되면 addEvent 뷰가 열립니다.
                        AddEventView(isShowingModal: $isShowingModal, completeAction: false, model: eventAddViewModel, catModelData: [], catListData: [], catSearchListData: [])
                    }
                    
                }
                VStack{
                    Button(action:
                            {
                        isShowingModal.toggle() // 버튼을 탭하면 모달을 열기/닫기
                    }
                           , label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.primaryColor)
                            .clipShape(Capsule())
                            .padding()
                    })
                    .padding()
                    .shadow(color:Color(.systemGray6), radius: 6, x: 0.0, y: 0.0)
                }
                //
                // SideMenu(isShowing: $isShowingSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $isShowingSideMenu)))
            }
        }
    }
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
        
    }
}

// #Preview {
//     CareCatView(presentSideMenu: Binding.constant(false))
// }
