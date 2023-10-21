//
//  SearchBar.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/20.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    @Binding var isShowingSearchModal:Bool 
    
    var body: some View {
           
                HStack {
                    TextField("Search...", text: $text)
                        .padding(8)
                        .padding(.horizontal, 32)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(8)
                        .overlay(
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.systemGray2))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                        )
                        // .onTapGesture {
                        //     isShowingSearchModal = true
                        // }
                    
                    .sheet(isPresented: $isShowingSearchModal) {
                                        SearchCatView(showConversationView: .constant(false))
                                    }
                    
                    // .sheet(isPresented: $isShowingSearchModal) {
                    //                         NavigationView {
                    //                             NavigationLink(destination: SearchCatView(showConversationView: .constant(false))) {
                    //                                 Text("Go to Another View")
                    //                             }
                    //                             .navigationBarTitle("Modal View")
                    //                         }
                    //                     }
                    
                    
                    
                    
                    if isEditing {
                        Button(action: {
                            isEditing = false
                            text = ""
                            UIApplication.shared.endEditing()
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.black)
                        })
                        .padding(.trailing, 8)
                    }
        }
    
        // NavigationView {
        //     NavigationLink(destination: SearchCatView(showConversationView: .constant(false))) {
        //         Text("Go to Another View")
        //     }
        //     .navigationBarTitle("Modal View")
        // }//: MODAL -> MODAL PUSH
      
    }
}

// 
// #Preview {
//     SearchBar()
// }
