//
//  ContentView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI

struct ContentView: View {
    // @Binding var presentSideMenu: Bool
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var presentSideMenu = false // 상태 변수 추가
    let isLoggedIn: Bool = UserDefaults.standard.object(forKey: "User") as? Bool ?? false
    
    var body: some View {
        Group {
            if(viewModel.didAuthenticateUser) {
                // NavigationLink(destination: MainTabView(presentSideMenu: $presentSideMenu)) {
                //                   Text("Log in successful!")
                //               }
                MainSideTabView()
            } else {
                LoginView()
            }
            
            // LoginView()
        }
    }
}

#Preview {
    ContentView()
}
