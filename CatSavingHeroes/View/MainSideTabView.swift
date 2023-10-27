//
//  MainSideTabView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import RealmSwift

struct MainSideTabView: View {
    // @State var presentSideMenu = false
    @State var presentNavigationBar = false
    @State var selectedSideMenuTab = 0
    @EnvironmentObject var model : AuthViewModel
    
    var body: some View {
        ZStack{
            
            // if !model.presentNavigationBar{
            NavigationBarView(presentNavigationBar: $presentNavigationBar)
                .padding(.horizontal, 15)
                .padding(.bottom)
            // .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
            // }
            
            TabView(selection: $selectedSideMenuTab) {
                //
                // MainTabView(presentSideMenu: presentSideMenu)
                //     .tabItem {
                //         Image(systemName: "house.fill")
                //         Text("Home")
                //     }
                //     .tag(0)
                
                CareCatView(presentNavigationBar: $presentNavigationBar)
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
                //
                // StateView(presentSideMenu: $presentSideMenu, presentNavigationBar: $presentNavigationBar)
                //     .tabItem {
                //         Image(systemName: "message.fill")
                //         Text("냥이들")
                //     }
                //     .tag(2)
                
                LocationFollowView(presentSideMenu: $presentNavigationBar)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("영웅업무")
                    }
                    .tag(3)
                
            }
            
            SideMenu(isShowing: $presentNavigationBar, content: 
                        AnyView(
                            SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentNavigationBar)
                        ))
        }
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

