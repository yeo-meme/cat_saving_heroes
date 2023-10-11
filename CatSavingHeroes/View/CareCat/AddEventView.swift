//
//  AddEventView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/11.
//

import SwiftUI

struct AddEventView: View {
   
    let catState = ["찾음", "밥줌", "인사", "놀이", "아픔"]
    @ObservedObject var model :EventAddViewModel


   
    
    
    @State private var searchText = ""
    @State private var careStateIndex = 0
    @State private var state  = ""
    @State private var memo = ""
    let user_id = "User ID"
    let cat_id = "Cat ID"
    @State var coordinate = "Coordinates"
    @State var address = "Address"
    @State var date = Date()
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding()
            
            Picker("고냥이의 이벤트 등록하기", selection: $careStateIndex) {
                ForEach(0 ..< catState.count) {
                    Text(self.catState[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Text("You've chosen '\(catState[careStateIndex])'.")
            
            TextField("나만의 메모", text: $memo)
                           .textFieldStyle(RoundedBorderTextFieldStyle()) // 선택적으로 스타일 지정
                           .padding()
            
            //false가 저장하기 텍스트 true가 인디케팅되는 상태
            CapsuleButton(text: "저장하기", disabled: false, isAnimating: false) {
                print("이벤트 기록하기 ")
                model.eventAddCat(state: state, user_id: user_id, cat_id: cat_id, memo: memo, coordinate: coordinate, address: address, date: date)
            }
        }
    }
}


//
// #Preview {
//     AddEventView(model: $model)
// }
