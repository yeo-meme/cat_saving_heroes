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
    @State private var searchText = ""
    @State private var isEditing = false
    // @Binding var user: User?
    let catNames = ["톰", "휴", "루시", "미스터 피부", "맥스", "미뉴엣", "오레오", "휴", "릴리", "히스테어", "오스카", "제리", "올리버"]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                // SearchBar(text: $searchText, isEditing: $isEditing)
                //     .onTapGesture { isEditing.toggle() }
                //     .padding()
                
                ScrollView {
                    VStack(spacing: 1) {
                        ForEach(catNames, id:\.self) { user in
                            Button(action: {
                                showConversationView.toggle()
                                // self.user = user
                                mode.wrappedValue.dismiss()
                            }, label: {
                                SearchCatCell()
                            })
                        }
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
