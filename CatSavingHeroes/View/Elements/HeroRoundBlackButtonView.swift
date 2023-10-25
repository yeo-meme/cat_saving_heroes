//
//  HeroRoundBlackButtonView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/25.
//

import SwiftUI

struct HeroRoundBlackButtonView: View {
    let text: String
    let action: () -> Void
    let selected : Bool
    var body: some View {
        Button(action:
            action
        , label: {
            if selected {
                Text(text)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 80, height: 30)
                    .background(Color.complementColor)
                    .cornerRadius(13)
                    .padding()
                    // .stroke(Color.black, lineWidth: 1)
            }else {
                Text(text)
                    .font(.headline)
                    .foregroundColor(Color.complementColor)
                    .frame(width: 80, height: 30)
                    .background(.white)
                    .cornerRadius(13)
                    .padding()
                    .border(Color.black, width: 1)
                    // .stroke(Color.black, lineWidth: 1)
            }
         
        })
        .disabled(true)
        .padding()
        .shadow(color:Color(.systemGray6), radius: 6, x: 0.0, y: 0.0)
    }
}

#Preview {
    HeroRoundBlackButtonView(text: "", action: {}, selected: false)
}
