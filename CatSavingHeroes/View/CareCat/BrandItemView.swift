//
//  BrandItemView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import SwiftUI

struct BrandItemView: View {
    // MARK: - PROPERTY
    @State private var selectedEvent: String? // 선택된 이벤트 식별자를 저장하는 상태 변수
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
                    RoundedRectangle(cornerRadius: 12).stroke(selectedEvent == event ? Color.primaryColor : Color.gray, lineWidth: selectedEvent == event ? 14 : 2) // 선택된 이벤트일 때 테두리 색상을 변경
                )
                .onTapGesture {
                                     selectedEvent = event // 이미지를 탭했을 때 선택된 이벤트를 업데이트
                                 }
          }
        }) //: GRID
        .frame(height: 200)
        .padding(15)
        
   
    }
}

#Preview {
    BrandItemView()
}
