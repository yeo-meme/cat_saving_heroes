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
                    ForEach(catsSearchedArr) { cat in
                        HStack(spacing: 12) {
                            
                            KFImage(URL(string: cat.cat_photo))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .padding(.leading)
                            
                            //TODO
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text(cat.name)
                                    .bold()
                                    .foregroundColor(.black)
                                
                                Text(cat.discover_address)
                                    .foregroundColor(Color(.systemGray))
                                
                            }
                            Spacer()
                        }
               
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
