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
    // @Binding var cats:[String]
    @Binding var catsSearchedArr:[Cats]
    
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
                        
                        //TODO
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(catsSearchedArr) { cat in
                                Text(cat.name)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                            Text("나는 고양이의 상태")
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
    SearchCatCell(catsSearchedArr: .constant([]))
}
