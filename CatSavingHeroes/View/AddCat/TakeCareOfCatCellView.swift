//
//  TakeCareOfCatCellView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/11/02.
//

import SwiftUI
import Kingfisher

struct TakeCareOfCatCellView: View {
    
    @ObservedObject var viewModel: TakeCareOfCatCellViewModel
    
    
    var body: some View {
        VStack(spacing: 1) {
            HStack(spacing: 12) {
                KFImage(URL(string:viewModel.userCat.cat_photo))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.userCat.name)
                        .bold()
                        .foregroundColor(.black)
                    // Text("나는 고양이의 상태")
                    //     .foregroundColor(Color(.systemGray))
                }//:catName
                Spacer()
            }
            // frame(height: 80)
            //     .background(Color.white)
            CustomDivider(leadingSpace: 84)
    }
    }
}
