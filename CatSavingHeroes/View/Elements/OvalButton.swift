//
//  OvalButton.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/16.
//

import SwiftUI

struct OvalButton: View {
    @State private var isPressed = false
    let text: String
    // let isAnimating: Bool
    // let action: () -> Void
    
    var body: some View {
        Button(action: {
                   // 버튼이 클릭되었을 때 실행할 작업
               }) {
                   // 버튼의 콘텐츠
                   Text(text)
                       .foregroundColor(.white)
                       .font(.system(size: 14))
               }
               .frame(width: 70, height: 30)
               .background(Color.gray)
               .cornerRadius(20)
               .disabled(isPressed)
               .shadow(color: Color(.systemGray6), radius: 6, x: 0.0, y: 0.0)
    }
}

#Preview {
    OvalButton(text: "")
}
