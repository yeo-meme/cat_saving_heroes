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
        HStack(alignment: .center, spacing: 6, content: {
            // Button(action: {
            //   if counter > 0 {
            //     // feedback.impactOccurred()
            //     counter -= 1
            //   }
            // }, label: {
            //   Image(systemName: "minus.circle")
            // })
            //
            // Text("\(counter)")
            //   .fontWeight(.semibold)
            //   .frame(minWidth: 36)
            //
            // Button(action: {
            //   if counter < 100 {
            //     // feedback.impactOccurred()
            //     counter += 1
            //   }
            // }, label: {
            //   Image(systemName: "plus.circle")
            // })
            
            Spacer()
            
            VStack{
                Button(action: {
                    // feedback.impactOccurred()
                }, label: {
                    Image(systemName: "lasso.and.sparkles")
                        .foregroundColor(.pink)
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
                        .foregroundColor(.pink)
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
                        .foregroundColor(.pink)
                })
                Text("돌봄냥")
                    .font(.headline)
                    .foregroundColor(Color.gray)
            }.padding(10)
            
        }) //: HSTACK
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
    }
}

#Preview {
    FavouriteDetailView()
}
