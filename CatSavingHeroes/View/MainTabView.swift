//
//  MainTabVeiw.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI

struct MainTabVeiw: View {
    var body: some View {
        TabView {
            // Tab 1
            
            VStack{
                Text("Tab 1")
                Button(action: {
                    AuthViewModel.shared.signOut()
                }, label: {
                    Text("로그아웃")
                })
            }
          
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            // Tab 2
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
            
            // Tab 3
            Text("Tab 3")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
            // Tab 4
            Text("Tab 4")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Save")
                }
        }
    }
}

#Preview {
    MainTabVeiw()
}
