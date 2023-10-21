//
//  CustomShape.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct CustomShape: Shape {
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 35, height: 35))
    
    return Path(path.cgPath)
  }
}

#Preview {
    CustomShape()
        .previewLayout(.fixed(width: 428, height: 120))
        .padding()
}
