//
//  FavouriteDetailView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct FavouriteDetailView: View {
  
    @ObservedObject var viewModel=FavouriteDetailViewModel()
    @State private var counter: Int = 0
    // @State private var isSeeCatBtn = false
    @Binding var isInterestCatBtn :Bool
    @Binding var isCareCatBtn:Bool
 
   
    // MARK: - BODY
    var body: some View {
      
    
        HStack(alignment: .center, spacing: 6, content: {
            Spacer()
            
            VStack{
                Button(action: {
                    isInterestCatBtn.toggle()
                    viewModel.interestAdd()
                    print("inter : \(isInterestCatBtn)")
                    print("care : \(isCareCatBtn)")
                    // feedback.impactOccurred()
                }, label: {
                    Image(systemName: "heart.circle")
                        .resizable()
                        .foregroundColor(isInterestCatBtn ? .pink:.gray)
                        .frame(width: 40, height: 40)
                })
                Text("관심냥")
                    .font(.headline)
                    .foregroundColor(Color.black)
            }.padding(10)
            
            //돌봄냥
            // VStack{
            //     //bolt.heart
            //     Button(action: {
            //         isCareCatBtn.toggle()
            //         viewModel.careAdd()
            //         // feedback.impactOccurred()
            //     }, label: {
            //         Image(systemName: "bolt.heart.fill")
            //             .resizable()
            //             .foregroundColor(isCareCatBtn ? .pink : .gray)
            //             .frame(width: 40, height: 40)
            //     })
            //     Text("돌봄냥")
            //         .font(.headline)
            //         .foregroundColor(Color.black)
            // }.padding(10)
        }) //: HSTACK
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
        .onAppear{
            viewModel.dataLoad { _ in
                 isInterestCatBtn = viewModel.checkCommonIds()
            }
        }
    }
}


