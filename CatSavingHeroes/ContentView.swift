//
//  ContentView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if (viewModel.userSession != nil) {
                MainTabVeiw()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
