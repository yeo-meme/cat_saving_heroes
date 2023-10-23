//
//  HomeView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentSideMenu.toggle()
                } label: {
                    Image("menu")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                Spacer()
            }
            
            // Spacer()
            // Text("Home View")
            // Button(action: {
            //     AuthViewModel.shared.signOut()
            // }, label: {
            //     Text("로그아웃")
            // })
            // Spacer()
        }
        .padding(.horizontal, 24)
    }
}
