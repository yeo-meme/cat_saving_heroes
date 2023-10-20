//
//  CategoryItemView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/19.
//

import SwiftUI

struct CategoryItemView: View {
  // MARK: - PROPERTY
  
  // let category: Category
  
  // MARK: - BODY
  
  var body: some View {
    Button(action: {}, label: {
      HStack(alignment: .center, spacing: 6) {
        Image("OIGG")
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30, alignment: .center)
          .foregroundColor(.gray)
        
        Text("이벤트 등록")
          .fontWeight(.light)
          .foregroundColor(.gray)
        
        Spacer()
      } //: HSTACK
      .padding()
      .background(Color.white.cornerRadius(12))
      .background(
        RoundedRectangle(cornerRadius: 12)
          .stroke(Color.gray, lineWidth: 1)
      )
    }) //: BUTTON
  }
}

#Preview {
    CategoryItemView()
}
