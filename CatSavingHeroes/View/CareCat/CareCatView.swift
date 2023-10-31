//
//  CareCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/08.
//

import SwiftUI
import MapKit
import RealmSwift
import Kingfisher

struct CareCatView: View {
    @Binding var showTopCustomView:Bool
    @EnvironmentObject var shop: Shop
    // @EnvironmentObject var strayModel: StrayCatsALLViewModel
    
    @EnvironmentObject var model:AddressManager
    @State private var selectedNumber = 1
    @State private var isDataLoaded = false
    private let numbers = [1,2,3,4,5]
    
    var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    let rowSpacing: CGFloat = 10
    
    //dummy data test
    let gridItems = [GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16), GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16)]
    let testData: [String] = [
        "아이폰 13 Pro",
        "맥북 프로",
        "아이패드 프로",
        "애플 워치",
        "에어팟 프로",
        "애플 펜슬",
        "맥 미니",
        "홈팟 미니"
    ]
    
    //네비게이션아이템
    @State var presentNavigationBar: Bool=false //네비게이션바아이템
    @Binding var presentSideMenu: Bool //네비게이션바아이템
    
    
    @State private var isShowingSideMenu = false //side
    @State var selectedSideMenuTab = 0//side
    
    @State private var isShowingModal = false
    
    @EnvironmentObject var locationManager: AddressManager
    @EnvironmentObject var trackModel: Model //트래킹 모델
    @State private var selectedColor = 0 // 초기 선택 색상 인덱스
    @EnvironmentObject var eventAddViewModel: EventAddViewModel
    
    // @StateObject var strayModel = StrayCatsALLViewModel()
    @State private var filterGeoCatsEvents: [EventsCat]? // @State로 선언
    
    @ObservedObject var strayModel=StrayCatsALLViewModel()
    
    //데이터 추가 로드시 8개씩
    @State private var strayCatList: [Cats] = [] // 전체 데이터 배열
    @State private var visibleCount = 8 // 현재 표시 중인 아이템 수
    // @Binding var presentSideMenu: Bool
    @State private var geoCatuuId:[String]=[]
    
    @State private var selectedSegment = 0
    let segments = ["100m", "200m", "300m","400m","500m"]
    
    
    @State var modifiedCatList:[Cats]?
    
    // Model 클래스의 인스턴스를 생성
    var body: some View {
        VStack {
            // NavigationBarView(presentNavigationBar: $presentNavigationBar)
            //           .padding(.horizontal, 15)
            //           .padding(.bottom, 5)
            //           .background(Color.white)
            ZStack(alignment: .bottomTrailing){
                
                if shop.showingProduct == false && shop.selectedProduct == nil {
                    VStack{
                        // if strayModel.isDataLoaded {
                        VStack{
                            MapViewCoordinator(locationManager: locationManager, eventAddViewModel: eventAddViewModel)
                                .frame(height: 300)
                            // Spacer()
                            // CategoryItemView(isShowingModal: $isShowingModal)
                            
                            Picker("", selection: $selectedSegment) {
                                ForEach(0..<segments.count, id: \.self) { index in
                                    Text(segments[index]).tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            
                            VStack(alignment: .leading, spacing: 6){
                                
                                ScrollView {
                                    LazyVGrid(columns: gridItems, spacing: 16) {
                                        ForEach(products) { product in
                                            // NavigationLink(destination: CatDetailView()) {
                                            StrayCatsItemView(product: product)
                                                .onTapGesture {
                                                    feedback.impactOccurred()
                                                    
                                                    withAnimation(.easeOut) {
                                                        shop.selectedProduct = product
                                                        shop.showingProduct = true
                                                        self.isShowingSideMenu.toggle()
                                                    }
                                                }
                                            // UserDefaults.standard.set(product, forKey: "Catitem")
                                            //
                                            // }
                                        } //: LOOP
                                        
                                        // if visibleCount < strayCatList.count {
                                        //     Button("더 보기") {
                                        //         visibleCount += 8 // 다음 8개 아이템을 표시
                                        //         if visibleCount > strayCatList.count {
                                        //             visibleCount = strayCatList.count // 끝까지 도달하면 모든 아이템을 표시
                                        //         }
                                        //     }
                                        // }
                                    }
                                    .padding()
                                }
                                // }
                                // } else {
                                //     Text("이벤트등록된 고양이가 없네요")
                                //     Spacer()
                                // }
                            } //List
                            .padding(.bottom, 10)
                            // .background(Color.red)
                            .sheet(isPresented: $isShowingModal) {
                                // 모달이 표시되면 addEvent 뷰가 열립니다.
                                AddEventView(isShowingModal: $isShowingModal, completeAction: false, model: eventAddViewModel, catModelData: [], catListData: [], catSearchListData: [])
                            }
                            
                        }
                        .onChange(of: selectedSegment) { value in
                            var coordi:Array=[0.0,0.0]
                            coordi[0]=model.currentGeoPoint?.longitude ?? 0.0
                            coordi[1]=model.currentGeoPoint?.latitude ?? 0.0
                            print("현재위치. : \(coordi)")
                            
                            let segmentsData = segments[value]
                            let meter = Int(segmentsData.replacingOccurrences(of: "m", with: ""))
                            if let meter = meter {
                                print("선택한 거리 : \(meter)")
                                strayModel.loadStrayAllCats(coordinates: coordi, meter: meter)
                            }
                        }
                        
                        
                    }
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
                } else {
                    CatDetailView(showTopCustomView: $showTopCustomView)
                }
            }
        }
      
        // SideMenu(isShowing: $isShowingSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $isShowingSideMenu)))
    }
    // .offset(y:-50)
    // .background(Color.red)
    
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


    // .onAppear{
        // var coordi:Array=[0.0,0.0]
        // coordi[0]=model.currentGeoPoint?.longitude ?? 0.0
        // coordi[1]=model.currentGeoPoint?.latitude ?? 0.0
        // print("현재위치onAppear : \(coordi)")
        //
        // let segmentsData = segments[0]
        // let meter = Int(segmentsData.replacingOccurrences(of: "m", with: ""))
        // if let meter = meter {
        //     print("선택한 거리onAppear: \(meter)")
        //     strayModel.loadStrayAllCats(coordinates: coordi, meter: 500)
        //     if let strayCatList = strayModel.filterGeoCatsList {
        //        modifiedCatList = strayCatList
        //         print("modifiedCatList : \(modifiedCatList) ")
        //            // ForEach(strayCatList) { cat in
        //            //     // modifiedCatList.append(cat)
        //            //     // catList = modifiedCatList
        //            // }
        //     }
        // }
        //
