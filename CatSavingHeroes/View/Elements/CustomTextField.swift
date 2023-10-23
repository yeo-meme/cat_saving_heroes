//
//  CustomTextField.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI

struct CustomTextField: View {
    let imageName: String
    let placeholder: String
    let isSecureField: Bool
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color(.systemGray4))
                    .padding(.trailing, 8)
                
                if isSecureField {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            
            Divider().background(Color(.systemGray4))
        }
    }
}


