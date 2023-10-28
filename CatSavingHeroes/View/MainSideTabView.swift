//
//  MainSideTabView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import RealmSwift

struct MainSideTabView: View {
    @Environment(\.presentationMode) var mode
    @State var isShowingSideMenu = false
    // @State var presentNavigationBar = false
    @State var selectedSideMenuTab = 0
    @EnvironmentObject var model : AuthViewModel
    @EnvironmentObject var locationManager: AddressManager
    @State private var showTopCustomView = true
 
    
    var goToAddViewButton: some View {
            HStack {
                Image(systemName: "waveform.path.badge.plus")
                    .foregroundColor(.white)

                Text("냥이추가")
                    .foregroundColor(.white)
                    .padding(.all, 5)
                    .frame(width: 55, height: 40)

            }
            .background(
                Capsule()
                    .fill(Color.primaryColor)
            )
        }
    
    var body: some View {
        ZStack{
            TabView(selection: $selectedSideMenuTab) {
                //
                // MainTabView(presentSideMenu: presentSideMenu)
                //     .tabItem {
                //         Image(systemName: "house.fill")
                //         Text("Home")
                //     }
                //     .tag(0)
                
                NavigationView{
                    CareCatView(presentSideMenu: $isShowingSideMenu)
                        .overlay(TopCustomView(), alignment: .top)
                }
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("주변돌봄")
                        }
                        .tag(0)
                
                
                
                // AddCatView(presentSideMenu: $isShowingSideMenu)
                //     .tabItem {
                //         Image(systemName: "message.fill")
                //         Text("냥이추가")
                //     }
                //     .tag(2)
                //
                NavigationView{
                    VStack{
                        if showTopCustomView {
                            TopCustomView()
                        }
                        
                        StateView(showTopCustomView: $showTopCustomView, presentSideMenu: $isShowingSideMenu)
                        
                        // if showTopCustomView {
                        //     StateView(showTopCustomView: $showTopCustomView, presentSideMenu: $isShowingSideMenu)
                        //         .overlay(TopCustomView(), alignment: .top)
                        // } else {
                        //     AddCatView(
                        //         mode: _mode, // 프레젠테이션 모드
                        //         locationManager: _locationManager, // 주소 관리자
                        //         showTopCustomView: $showTopCustomView, // 상단 커스텀 뷰를 표시할지 여부를 바인딩하는 데 사용됨
                        //         viewModel: _model, // AuthViewModel 환경 객체
                        //         catViewModel: AddCatViewModel() // AddCatViewModel 초기 인스턴스
                        //     )
                        // }
                    }
                }
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("냥이들")
                    }
                    .tag(2)
                
                NavigationView{
                    LocationFollowView(presentSideMenu: $isShowingSideMenu)
                        .overlay(TopCustomView(), alignment: .top)
                }
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("영웅업무")
                    }
                    .tag(1)
                
                
            }
            // 
            // SideMenu(isShowing: $isShowingSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $isShowingSideMenu)))
        }
    }
}

struct TopCustomView: View {
    var body: some View {
        NavigationBarView()
            .padding(.horizontal, 15)
            .padding(.bottom)
        // .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}

struct NavigationMenuView: View {
    
    @Binding var presentSideMenu:Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.presentSideMenu.toggle()
            }
        }) {
            Image(systemName: "line.horizontal.3")
        }
    }
}

// #Preview {
//     MainSideTabView()
// }

