//
//  HeaderDetailView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct HeaderDateView: View {
  // MARK: - PROPERTY
  
  @EnvironmentObject var shop: Shop
  
  // MARK: - BODY
  
  var body: some View {
    VStack(alignment: .leading, spacing: 6, content: {
      Text("최근 보살핌")
        Text("2023.11.03")
            .font(.subheadline)
        .fontWeight(.black)
    }) //: VSTACK
    .foregroundColor(.white)
  }
}

#Preview {
    HeaderDateView()
}
