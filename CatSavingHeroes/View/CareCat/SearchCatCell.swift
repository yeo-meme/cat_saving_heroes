//
//  SearchCatCell.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI
import Kingfisher

struct SearchCatCell: View {
    // let user: User
    
    var body: some View {
        VStack(spacing: 1) {
            HStack(spacing: 12) {
                // KFImage(URL(string: user.profileImageUrl))
                Image("OIGG")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("냥냥이")
                        .bold()
                        .foregroundColor(.black)
                    
                    Text("user.status.title")
                        .foregroundColor(Color(.systemGray))
                }
                
                Spacer()
            }
            .frame(height: 70)
            .background(Color.white)
            
            CustomDivider(leadingSpace: 76)
        }
    }
}

#Preview {
    SearchCatCell()
}
