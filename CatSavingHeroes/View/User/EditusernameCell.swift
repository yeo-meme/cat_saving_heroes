//
//  EditusernameCell.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import SwiftUI

struct EditUsernameCell: View {
    @ObservedObject var viewModel: EditProfileViewModel
    @Binding var username: String
    
    var body: some View {
        VStack(spacing: 1) {
            HStack {
                TextField(viewModel.user.name, text: $username)
                
                Spacer()
                
//                Button(
//                    action: { username = "" },
//                    label: { Image(systemName: "pencil") })
            }
            .padding()
            
            CustomDivider(leadingSpace: 16)
        }
        .background(Color.white)
    }
}

