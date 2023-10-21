//
//  EventAddButton.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct EventAddButton: View {
    @Binding var isButtonClicked: Bool
    let text: String
    let action: () -> Void
    
    var body: some View {
        // if isButtonClicked {
        
        Button(action: {
            self.action()
            self.isButtonClicked.toggle()
        }, label: {
            Text(text)
                .font(.headline)
                .frame(width: 60, height: 50)
                .background(isButtonClicked ? Color.blueButtonBackroundColor.cornerRadius(8) : Color.white.cornerRadius(8))
                .foregroundColor(isButtonClicked ? Color.white : .black)
                // .clipShape(Capsule())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding()
        })
        .disabled(isButtonClicked)
        .shadow(color:Color(.systemGray6), radius: 6, x: 0.0, y: 0.0)
        
    }
}

// #Preview {
//     EventAddButton(text: "찾음", isButtonClicked: .constant(false),  action: {})
// }
