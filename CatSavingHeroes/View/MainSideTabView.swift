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
                
                LocationBasedCatView(presentSideMenu: $presentSideMenu)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("주변냥")
                    }
                    .tag(1)
                
                AddCatView(presentSideMenu: $presentSideMenu)
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("냥이추가")
                    }
                    .tag(2)
                
                RecordLocationView(presentSideMenu: $presentSideMenu)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("동선기록")
                    }
                    .tag(3)
                
                // SaveView(presentSideMenu: $presentSideMenu)
                //     .tabItem {
                //         Image(systemName: "person.fill")
                //         Text("저장")
                //     }
                //     .tag(4)
            }

                SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
                   
        }
        
   
    }
}


#Preview {
    MainSideTabView()
}
