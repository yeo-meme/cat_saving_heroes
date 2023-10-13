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
                
                CareCatView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("주변돌봄")
                    }
                    .tag(1)
                
                AddCatView(catViewModel: catModel)
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("냥이추가")
                    }
                    .tag(2)
                
                LocationFollowView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("영웅업무")
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


// #Preview {
//     MainSideTabView(catModel: $catModel)
// }
