//
//  LogoView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/20.
//

import SwiftUI

struct LogoView: View {
  var body: some View {
    HStack(spacing: 4) {
      Text("Cat".uppercased())
        .font(.title3)
        .fontWeight(.black)
        .foregroundColor(.black)
      
      Image("OIGG1")
        .resizable()
        .scaledToFit()
        .frame(width: 30, height: 30, alignment: .center)
      
      Text("Hero".uppercased())
        .font(.title3)
        .fontWeight(.black)
        .foregroundColor(.black)
    } //: HSTACK
  }
}
#Preview {
    LogoView()
}
