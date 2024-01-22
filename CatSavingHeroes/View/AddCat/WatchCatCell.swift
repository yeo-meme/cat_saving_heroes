//
//  WatchCatCell.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI
import Kingfisher

struct WatchCatCell: View {
    @ObservedObject var viewModel: WatchItemCellModel
    @EnvironmentObject var model: AuthViewModel
    // @Binding var path: [CatsNavigation]
    
    var body: some View {
        
        if let userCat = viewModel.userCat {
            // NavigationLink(destination: AddEventView()
            // )
            // {
                    VStack(spacing: 1) {
                        HStack(spacing: 12) {
                            KFImage(URL(string:userCat.cat_photo))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .padding(.leading)
                            
                            // VStack(alignment: .leading, spacing: 4) {
                            Text(userCat.name)
                                .bold()
                                .foregroundColor(.black)
                            // }//:catName
                          
                            Spacer()
                            
                            Text("이벤트추가")
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                )
                        }
                        // frame(height: 80)
                        //     .background(Color.white)
                        CustomDivider(leadingSpace: 84)
                    }
          
            // }
            
            // VStack(spacing: 1) {
            //     HStack(spacing: 12) {
            //         KFImage(URL(string:userCat.cat_photo))
            //             .resizable()
            //             .scaledToFill()
            //             .frame(width: 48, height: 48)
            //             .clipShape(Circle())
            //             .padding(.leading)
            //         
            //         // VStack(alignment: .leading, spacing: 4) {
            //         Text(userCat.name)
            //             .bold()
            //             .foregroundColor(.black)
            //         // }//:catName
            //         Spacer()
            //         
            //         
            //         Text("이벤트추가")
            //             .font(.footnote)
            //             .foregroundColor(Color(UIColor.systemGray2))
            //             .padding(3)
            //             .frame(minWidth: 62)
            //             .overlay(
            //                 Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
            //             )
            //         
            //     }
            //     // frame(height: 80)
            //     //     .background(Color.white)
            //     CustomDivider(leadingSpace: 84)
            // }
            // }
        }
       
        
    }
}

//
// #Preview {
//     WatchCatCell(viewModel: WatchItemCellModel())
// }
