//
//  BrandItemView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import SwiftUI

struct BrandItemView: View {
    // MARK: - PROPERTY
    
    let eventBtn = ["feeding","found","greeting","pain","play","play2"]
    
    // MARK: - BODY
    let columnSpacing: CGFloat = 10
    var gridLayout: [GridItem] {
      return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    let rowSpacing: CGFloat = 10
    
    var body: some View {
        LazyHGrid(rows: gridLayout, spacing: columnSpacing, content: {
            ForEach(eventBtn,id: \.self) { event in
              Image(event)
                .resizable()
                .scaledToFit()
                .padding(3)
                .background(Color.white.cornerRadius(12))
                .background(
                  RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1)
                )
          }
        }) //: GRID
        .frame(height: 200)
        .padding(15)
        
   
    }
}

#Preview {
    BrandItemView()
}
