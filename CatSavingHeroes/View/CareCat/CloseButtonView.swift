//
//  CloseButtonView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct CloseButtonView: View {
    // @Binding var isShowingModal:Bool
    
    var body: some View {
        HStack {
            Button {
                // self.isShowingModal.toggle()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 30)) // 원하는 크기로 조정
                    .foregroundColor(.black) // 검은색으로 설정
                    .font(.system(size: 30, weight: .bold)) // 굵게 만들기
            }
            Spacer()
        }
        .padding(.leading, 20)
    }
}

#Preview {
    CloseButtonView()
}
