//
//  MainSideTabView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import RealmSwift


enum Tab {
    case home, cats
}

enum CatsNavigation: Hashable{
    case care
}

//main
struct MainTabView: View {
    
    @State private var selectedTab: Tab = .home
    @State private var catNavigationStack: [CatsNavigation] = []
    
    
    @Environment(\.presentationMode) var mode
    @State var isShowingSideMenu = false
    @State var selectedSideMenuTab = 0
    @EnvironmentObject var model : AuthViewModel
    @EnvironmentObject var locationManager: AddressManager
    // @State private var showTopCustomView = true
    @State private var settingViewShowUP = false
    @State private var shouldShowSettings = false
    
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
        NavigationView{
            ZStack{
                // TabView(selection: $selectedSideMenuTab) {
                TabView(selection: tabSelection()) {
                    VStack {
                        if model.showTopCustomView {
                            TopCustomView(presentNavigationBar: $isShowingSideMenu)
                        }
                        CareCatView(presentSideMenu: $isShowingSideMenu)
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("주변돌봄")
                    }
                    .tag(Tab.home)
                    
                    VStack {
                        if model.showTopCustomView {
                            TopCustomView(presentNavigationBar: $isShowingSideMenu)
                        }
                            StateView(path: $catNavigationStack, presentSideMenu: $isShowingSideMenu)
                            // AddEventView()
                    }
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("냥이들")
                    }
                    .tag(Tab.cats)
                    
                    //showTopCustomView
                    // NavigationView{
                    //     VStack {
                    //         TopCustomView(presentNavigationBar: $isShowingSideMenu)
                    //         TrackingHeroView(weatherModel: WeatherViewModel())
                    //     }
                    // }
                    // .tabItem {
                    //     Image(systemName: "location.fill")
                    //     Text("영웅기록")
                    // }
                    // .tag(3)
                    // 
                    // NavigationView{
                    //     VStack {
                    //         TopCustomView(presentNavigationBar: $isShowingSideMenu)
                    //         HeroCalendarView()
                    //     }
                    // }
                    // .tabItem {
                    //     Image(systemName: "calendar")
                    //     Text("영웅일지")
                    // }
                    // .tag(4)
                }
                .onAppear {
                    selectedSideMenuTab = 0 // 초기화면을 설정
                }
                .onChange(of: selectedSideMenuTab) { newTabValue in
                    print("Selected tab is now \(newTabValue)")
                    if newTabValue == 1 {
                        shouldShowSettings = true
                    }
                }
                
                if shouldShowSettings {
                    NavigationLink(destination: SettingsView(model.currentUser ?? MOCK_USER), isActive: $shouldShowSettings) {
                        EmptyView()
                    }
                }
                
                SideMenu(isShowing: $isShowingSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $isShowingSideMenu, weatherManager: WeatherManager())))
                
            }
        }
        
    }
    
    func mainView(for selectedTab: SideMenuRowType) -> some View {
        switch selectedTab {
        case .home:
            return AnyView(CareCatView( presentSideMenu: .constant(true)))
        case .mypage:
            return AnyView(SettingsView(model.currentUser ?? MOCK_USER))
            // case .logout:
            // 로그아웃 로직
            // return AuthViewModel.shared.signOut()
        case .logout:
            return AnyView(SettingsView(model.currentUser ?? MOCK_USER))
        }
    }
    
    
    struct TopCustomView: View {
        @Binding var presentNavigationBar :Bool
        var body: some View {
            NavigationBarView(presentNavigationBar: $presentNavigationBar)
                .padding(.horizontal, 15)
                .padding(.bottom, 5)
                .background(Color.white)
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
}



extension MainTabView {
    private func tabSelection() -> Binding<Tab> {
        Binding {
            self.selectedTab
        } set: { tappedTab in
            if tappedTab == self.selectedTab { //같다면 다시 탭한걸로 추정한다
                if catNavigationStack.isEmpty {
                    print("catNavigationStack.isEmpty")
                } else {
                    print("catNavigationStack. NOT!!!! Empty")
                    catNavigationStack = []
                }
            }
            self.selectedTab = tappedTab
        }
    }
}
