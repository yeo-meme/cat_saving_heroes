//
//  FavouriteDetailView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct FavouriteDetailView: View {
  
    @ObservedObject var viewModel:FavouriteDetailViewModel
    
    @State private var counter: Int = 0
    @State private var isSeeCatBtn = false
    @State private var isInterestCatBtn = false
    @State private var isCareCatBtn = false
 
    
    // MARK: - BODY
    var body: some View {
        // HStack(alignment: .center, spacing: 6){
        //     VStack{
        //         Image(systemName: "lasso.and.sparkles")
        //             .resizable()
        //             .foregroundColor(.black)
        //             .frame(width: 25, height: 25)
        //         Text("30")
        //     }.padding(20)
        //     VStack{
        //     
        //         Text("4")
        //     }.padding(20)
        //     VStack{
        //         Image(systemName: "bolt.heart.fill")
        //             .resizable()
        //             .foregroundColor(.black)
        //             .frame(width: 25, height: 25)
        //         Text("2")
        //     }.padding(20)
        //     Spacer()
        // }
    
        HStack(alignment: .center, spacing: 6, content: {
            Spacer()
            // VStack{
            //     Button(action: {
            //         isSeeCatBtn.toggle()
            //         viewModel.seeAdd()
            //     }, label: {
            //         Image(systemName: "lasso.and.sparkles")
            //             .resizable()
            //             .foregroundColor(isSeeCatBtn ?
            //                 .pink : .gray)
            //             .frame(width: 40, height: 40)
            //     })
            //     Text("추가냥")
            //         .font(.headline)
            //         .foregroundColor(Color.black)
            //     
            // }.padding(10)
            
            VStack{
                Button(action: {
                    isInterestCatBtn.toggle()
                    viewModel.interestAdd()
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
            
            VStack{
                //bolt.heart
                Button(action: {
                    isCareCatBtn.toggle()
                    viewModel.careAdd()
                    // feedback.impactOccurred()
                }, label: {
                    Image(systemName: "bolt.heart.fill")
                        .resizable()
                        .foregroundColor(isCareCatBtn ? .pink : .gray)
                        .frame(width: 40, height: 40)
                })
                Text("돌봄냥")
                    .font(.headline)
                    .foregroundColor(Color.black)
            }.padding(10)
         
        }) //: HSTACK
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
        // .background(Color.black)
    }
}


