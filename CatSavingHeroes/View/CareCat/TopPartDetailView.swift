//
//  TopPartDetailView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import Foundation
import SwiftUI

struct TopPartDetailView: View {
  // MARK: - PROPERTY
  
  @EnvironmentObject var shop: Shop
  @State private var isAnimating: Bool = false
  
  // MARK: - BODY
  
  var body: some View {
    HStack(alignment: .center, spacing: 6, content: {
      // PRICE
      VStack(alignment: .leading, spacing: 6, content: {
          
          Text(shop.selectedProduct?.address ?? "")
                  .fontWeight(.semibold)
        
          Text(shop.selectedProduct?.name ?? "")
          .font(.largeTitle)
          .fontWeight(.black)
          .scaleEffect(1.35, anchor: .leading)
      })
      .offset(y: isAnimating ? -50 : -75)
      
      Spacer()
      
      // PHOTO
        Image(shop.selectedProduct?.image ?? "")
        .resizable()
        .scaledToFit()
        .clipShape(Capsule())
        .frame(width: 200, height: 200)
        .offset(y: isAnimating ? 0 : -35)
    }) //: HSTACK
    .onAppear(perform: {
      withAnimation(.easeOut(duration: 0.75)) {
        isAnimating.toggle()
      }
    })
  }
}

