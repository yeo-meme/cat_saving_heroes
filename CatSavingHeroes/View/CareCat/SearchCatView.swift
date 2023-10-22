//
//  SearchCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/12.
//

import SwiftUI
import RealmSwift


struct SearchCatView: View {
    
    @Environment(\.presentationMode) var mode
    // @ObservedObject var viewModel = ChatPartnersViewModel()
    @Binding var showConversationView: Bool  
    @Binding var catNames: [String]
    @State private var searchText = ""
    @State private var isEditing = false
    // @Binding var user: User?
    // var catNames = ["톰", "휴", "루시", "미스터 피부", "맥스", "미뉴엣", "오레오", "휴", "릴리", "히스테어", "오스카", "제리", "올리버"]
    // 
    // @State var cat : [CatRealmModel]
    

    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            // ScrollView{
            //     VStack(spacing:1){
            //         SearchCatView(showConversationView: .constant(false))
            //     }
            // }
            
            
            ScrollView {
                ScrollView {
                    VStack(spacing: 1) {
                        ForEach(catNames, id:\.self) { user in
                            Button(action: {
                                showConversationView.toggle()
                                // self.user = user
                                mode.wrappedValue.dismiss()
                            }, label: {
                                SearchCatCell(cats: $catNames)
                            })
                        }
                    }
                    .onAppear{
                       print("cat arrrrrr: \(catNames)")
                    }
                }
            }
        }
        // .showErrorMessage(showAlert: $viewModel.showErrorAlert, message: viewModel.errorMessage)
    }
    
    
}
// 
// #Preview {
//     SearchCatView()
// }
