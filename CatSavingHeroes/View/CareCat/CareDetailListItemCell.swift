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
                    .frame(width: .infinity, height: 70) // 원하는 크기로 설정
                    .cornerRadius(50) // 원하는 모서리 반경 설정
                    .shadow(color: Color(.systemGray4), radius: 3, x: 0, y: 0) // 그림자 효과
                
                HStack {
                    Image("OIGG")
                        .resizable()
                        .frame(width: 50,height: 50)
                        .padding(.leading, 20) // 이미지를 왼쪽으로 이동
                    
                    VStack(alignment:.leading){
                        Text("밥줬어")
                            .font(.system(size: 16, weight: .bold)) // 글자 크기 및 스타일 설정
                            .fontWeight(.bold) // 글자 두께 설정
                            .foregroundColor(Color.black) // 글자 색상 설정
                        
                        Text("로얄캐닌으로다가")
                            .font(.callout) // 글자 크기 및 스타일 설정
                            .fontWeight(.bold) // 글자 두께 설정
                            .foregroundColor(Color.black) // 글자 색상 설정
                        }
                    .padding(.leading)
                    Spacer() // 중앙 정렬을 위해 Spacer 추가
                    
                    Text("2023/10/27")
                        .font(.system(size: 13, weight: .semibold)) // 글자 크기 및 스타일 설정
                        .fontWeight(.bold) // 글자 두께 설정
                        .foregroundColor(Color.black) // 글자 색상 설정
                        .padding(.trailing, 20) // 오른쪽 15 패딩
                        
                }
            }
            .padding(.trailing)
            .padding(.leading)
          
        }.padding(.vertical , 5)
    }
}

#Preview {
    CareDetailListItemCell()
}
