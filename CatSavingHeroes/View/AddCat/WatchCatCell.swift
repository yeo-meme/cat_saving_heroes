//
//  WatchCatCell.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI
import Kingfisher

struct WatchCatCell: View {
    @ObservedObject var viewModel: WatchCellViewModel
    
    var body: some View {
            VStack(spacing: 1) {
                HStack(spacing: 12) {
                    Image("OIGG")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                        .padding(.leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("dummy")
                            .bold()
                            .foregroundColor(.black)
                        Text("user.status.title")
                            .foregroundColor(Color(.systemGray))
                    }//:catName
                    Spacer()
                }
                frame(height: 80)
                    .background(Color.white)
                CustomDivider(leadingSpace: 84)
        }
    }
}

// 
// #Preview {
//     WatchCatCell(viewModel: WatchItemCellModel())
// }
