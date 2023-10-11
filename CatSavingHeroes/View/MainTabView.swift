//
//  MainTabVeiw.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI

struct MainTabView: View {
    @Binding var presentSideMenu: Bool
    @State private var showSheet = false
    
    var body: some View {
   
        VStack{
            Spacer()
            Text("Home View")
            Button(action: { self.showSheet = true },
                   label: { Text("Log out").font(.system(size: 18, weight: .semibold)) }
            )
            .foregroundColor(.red)
            .font(.system(size: 18))
            .frame(width: UIScreen.main.bounds.width, height: 50)
            .background(Color.white)
            .actionSheet(isPresented: $showSheet) {
                ActionSheet(title: Text("Log out"),
                            message: Text("로그아웃 하시면 자동로그인 풀려서 다시 로그인하셔야 해요"),
                            buttons: [
                                .destructive(Text("웅 로그아웃"), action: { AuthViewModel.shared.signOut() }),
                                .cancel(Text("그건 귀찮은데")) ])
            }
            Spacer()
        }
       
    }
}

// #Preview {
//     MainTabVeiw()
// }
