//
//  MainSideTabView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI

struct MainSideTabView: View {
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    @State var catModel = AddCatViewModel()
    
    var body: some View {
        ZStack{
            NavigationBarView(presentSideMenu: $presentSideMenu)
                .padding(.horizontal, 15)
                .padding(.bottom)
            // .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
            .background(Color.yellow)}
            
            TabView(selection: $selectedSideMenuTab) {
                
                MainTabView(presentSideMenu: presentSideMenu)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                CareCatView(presentSideMenu: $presentSideMenu)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("주변돌봄")
                    }
                    .tag(1)
                
                
                // AddCatView(presentSideMenu: $presentSideMenu, catViewModel: catModel)
                //     .tabItem {
                //         Image(systemName: "message.fill")
                //         Text("냥이추가")
                //     }
                //     .tag(2)
                
                StateView(presentSideMenu: $presentSideMenu)
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("냥이들")
                    }
                    .tag(2)
                
                LocationFollowView(presentSideMenu: $presentSideMenu)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("영웅업무")
                    }
                    .tag(3)
                
            }
            
            // SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
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
//     MainSideTabView(catModel: $catModel)
// }

