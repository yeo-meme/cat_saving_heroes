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
    }
}

// 
// #Preview {
//     SearchBar()
// }
