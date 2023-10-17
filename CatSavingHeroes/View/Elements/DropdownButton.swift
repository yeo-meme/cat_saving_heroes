//
//  DropdownButton.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/16.
//

import SwiftUI

struct DropdownButton: View {
    @State private var selectedOption = "Option 1"
    
    var body: some View {
        Text("")
        // Button(action: {
        //            // 드롭다운 메뉴가 열립니다.
        //        }) {
        //            Text(selectedOption)
        //        }
        //        .menu(content: {
        //            // 드롭다운 메뉴의 옵션
        //            Button(action: {
        //                self.selectedOption = "Option 1"
        //            }) {
        //                Text("Option 1")
        //            }
        //            Button(action: {
        //                self.selectedOption = "Option 2"
        //            }) {
        //                Text("Option 2")
        //            }
        //            Button(action: {
        //                self.selectedOption = "Option 3"
        //            }) {
        //                Text("Option 3")
        //            }
        //        })
    }
}

#Preview {
    DropdownButton()
}
