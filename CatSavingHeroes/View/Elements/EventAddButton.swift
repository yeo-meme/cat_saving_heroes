//
//  EventAddButton.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI

struct EventAddButton: View {
    // @Binding var isButtonClicked: Bool
    @Binding var buttonStates: [Bool]
    @Binding var careStateIndex: Int
    
    let text: String
    let action: () -> Void
    
    var body: some View {
        // if isButtonClicked {
        
        Button(action: {
            self.action()
            // self.isButtonClicked.toggle()
            toggleState(index:careStateIndex)
        }, label: {
            Text(text)
                .font(.headline)
                .frame(width: 60, height: 50)
                .background(buttonStates[careStateIndex] ? Color.blue.cornerRadius(8) : Color.white.cornerRadius(8))
                // .background(isButtonClicked ? Color.blueButtonBackroundColor.cornerRadius(8) : Color.white.cornerRadius(8))
                // .foregroundColor(isButtonClicked ? Color.white : .black)
                // .clipShape(Capsule())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(0)
        })
        // .disabled(isButtonClicked)
        .shadow(color:Color(.systemGray6), radius: 6, x: 0.0, y: 0.0)
        // .background(
        //     ForEach(buttonStates.indices, id: \.self) { index in
        //                     buttonStates[index] ? Color.blue : Color.white
        //         // print("button 들어오는값 : \(buttonStates[index]) ")
        //                 }
        // )
    }
    // func toggleState(index: Int) {
    //     
    //     // print("button 들어와서 토글 : \(buttonStates[buttonNumber])")
    //     // for i in 0..<buttonStates.count {
    //     //     if i == buttonNumber {
    //     //         buttonStates[i] = !buttonStates[i]
    //     //         print("button 같은면 전환 : \(buttonStates[i])")
    //     //     } else {
    //     //         buttonStates[i] = false
    //     //         print("button 다르면 false : \(buttonStates[i])")
    //     //     }
    //     // }
    //     //
    //     // buttonStates[index].toggle() // 토글해 true->false
    //     for i in 0..<buttonStates.count {
    //               if i != index {
    //                   buttonStates[i] = false
    //                   print("button 아닌거 변환값 : \(buttonStates[i])")
    //               } else {
    //                   buttonStates[i] = true
    //                   print("button 긴거 변환값 : \(buttonStates[i])")
    //               }
    //           }
    // }
    
    func toggleState(index: Int)  {
        // buttonStates = [false, false, false, false, false]
        // 현재 버튼 상태 토글
        buttonStates[index].toggle()
        print("돌려라 돌려 들어온값 : \(buttonStates[index])")
        // 다른 버튼들의 상태를 비활성화 (흰색)로 설정
        for i in 0..<buttonStates.count {
            if i != index {
                buttonStates[i] = false
            }else{
                buttonStates[i] = true
            }
            print("돌려라 돌려 : \(buttonStates[i])")
        }
    }
    
    // func getIndex() -> Int {
    //   // 버튼 상태 배열에서 맨 처음 활성화된 버튼의 인덱스를 반환합니다.
    //   return buttonStates.firstIndex(where: { $0 }) ?? 0
    // }
    
    // func getIndex() -> Int {
    //         // Calculate the index based on the buttonStates array.
    //         // You can implement your logic here to determine the active button.
    //         // For example, return 0 for the first button, 1 for the second, and so on.
    //         // Here, we assume the first active button should be displayed in blue.
    //         for (index, isActive) in buttonStates.enumerated() {
    //             if isActive {
    //                 return index
    //             }
    //         }
    //         return 0 // Default to the first button if none is active.
    //     }
    
}
   

//
// #Preview {
//     EventAddButton(buttonStates: .constant([Bool]), text: "", action: () -> Void)
// }
