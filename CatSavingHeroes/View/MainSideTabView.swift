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
    
    var body: some View {
        ZStack{
            TabView(selection: $selectedSideMenuTab) {
                NavigationView {
                        MainTabView(presentSideMenu: $presentSideMenu)
                            .navigationBarItems(
                                trailing: Button(action: {
                                    withAnimation {
                                        self.presentSideMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                }
                            )
                       
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
                
                FavoriteView(presentSideMenu: $presentSideMenu)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorites")
                    }
                    .tag(1)
                
                ChatView(presentSideMenu: $presentSideMenu)
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Chat")
                    }
                    .tag(2)
                
                ProfileView(presentSideMenu: $presentSideMenu)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(3)
            }

                SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
                   
        }
   
    }
}


#Preview {
    MainSideTabView()
}
