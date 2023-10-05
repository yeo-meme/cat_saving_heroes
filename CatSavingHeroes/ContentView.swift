//
//  ContentView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var presentSideMenu = false // 상태 변수 추가
    var body: some View {
        Group {
            if ($viewModel.userSession != nil) {
                // MainTabVeiw(presentSideMenu: $presentSideMenu)
                MainSideTabView()
               
                 
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
