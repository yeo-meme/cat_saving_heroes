//
//  CategoryItemView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/19.
//

import SwiftUI

struct CategoryItemView: View {

    @Binding var isShowingModal:Bool
    @EnvironmentObject var eventAddViewModel: EventAddViewModel
    
  var body: some View {
    Button(action: {
        isShowingModal.toggle() // 버튼을 탭하면 모달을 열기/닫기
    }, label: {
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
    .sheet(isPresented: $isShowingModal) {
        // 모달이 표시되면 addEvent 뷰가 열립니다.
        AddEventView(model: eventAddViewModel)
    }
  }
}

// #Preview {
//     CategoryItemView()
// }
