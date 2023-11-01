//
//  FavouriteDetailView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct FavouriteDetailView: View {
    // MARK: - PROPERTY
    
    @State private var counter: Int = 0
    
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
            VStack{
                Button(action: {
                    // feedback.impactOccurred()
                }, label: {
                    Image(systemName: "lasso.and.sparkles")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                })
                Text("보는냥")
                    .font(.headline)
                    .foregroundColor(Color.gray)
                
            }.padding(10)
            
            VStack{
                Button(action: {
                    // feedback.impactOccurred()
                }, label: {
                    Image(systemName: "heart.circle")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                })
                Text("관심냥")
                    .font(.headline)
                    .foregroundColor(Color.gray)
            }.padding(10)
            
            VStack{
                //bolt.heart
                Button(action: {
                    // feedback.impactOccurred()
                }, label: {
                    Image(systemName: "bolt.heart.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                })
                Text("돌봄냥")
                    .font(.headline)
                    .foregroundColor(Color.gray)
            }.padding(10)
         
        }) //: HSTACK
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
        // .background(Color.black)
    }
}

#Preview {
    FavouriteDetailView()
}
