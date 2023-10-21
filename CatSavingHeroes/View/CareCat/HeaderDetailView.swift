//
//  HeaderDetailView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct HeaderDetailView: View {
  // MARK: - PROPERTY
  
  // @EnvironmentObject var shop: Shop
  
  // MARK: - BODY
  
  var body: some View {
    VStack(alignment: .leading, spacing: 6, content: {
      Text("Protective Gear")
      
      // Text(shop.selectedProduct?.name ?? sampleProduct.name)
      //   .font(.largeTitle)
      //   .fontWeight(.black)
    }) //: VSTACK
    .foregroundColor(.white)
  }
}

#Preview {
    HeaderDetailView()
}
