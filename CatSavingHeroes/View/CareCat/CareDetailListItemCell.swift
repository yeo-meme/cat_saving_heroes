//
//  CareDetailListItemCell.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/27.
//

import SwiftUI

struct CareDetailListItemCell: View {
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .fill(.white)
                    .frame(width: .infinity, height: 60) // 원하는 크기로 설정
                    .cornerRadius(50) // 원하는 모서리 반경 설정
                    .shadow(color: Color(.systemGray4), radius: 3, x: 3, y: 3) // 그림자 효과
                HStack {
                    Circle()
                        .frame(width: 12, height: 12, alignment: .center)
                        .foregroundColor(Color.primaryColor)
                    
                    Text("찾음")
                        .font(.footnote)
                        .foregroundColor(Color(UIColor.systemGray2))
                        .frame(minWidth: 62)
                        .padding(3)
                        .overlay(
                            Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                        ).padding(.leading,10)
                        
                    Spacer() // 중앙 정렬을 위해 Spacer 추가
                    
                    Text("2023/10/27")
                        .font(.system(size: 13, weight: .semibold)) // 글자 크기 및 스타일 설정
                        .fontWeight(.bold) // 글자 두께 설정
                        .foregroundColor(Color.black) // 글자 색상 설정
                    
                }//:HSTACK
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
            .padding(.trailing, 32)
            .padding(.leading, 32)
        }
    }
}

#Preview {
    CareDetailListItemCell()
}
// Text("밥줬어")
//     .font(.system(size: 16, weight: .bold)) // 글자 크기 및 스타일 설정
//     .fontWeight(.bold) // 글자 두께 설정
//     .foregroundColor(Color.black) // 글자 색상 설정
//
// Text("로얄캐닌으로다가")
//     .font(.callout) // 글자 크기 및 스타일 설정
//     .fontWeight(.bold) // 글자 두께 설정
//     .foregroundColor(Color.black) // 글자 색상 설정
