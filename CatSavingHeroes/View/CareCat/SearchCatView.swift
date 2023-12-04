//
//  SearchCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/12.
//

import SwiftUI
import RealmSwift


struct SearchCatView: View {
    
    @Environment(\.presentationMode) var mode
    @Binding var showConversationView: Bool
    @State private var searchText = ""
    @Binding var isEditing:Bool

    @State var selectedCatArr: [Cats] // 선택한 셀의 내용을 저장할 변수
    @Binding var choiceCat: Cats? // 선택한 셀의 내용을 저장할 변수
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                ScrollView {
                    VStack(spacing: 1) {
                        ForEach(selectedCatArr) { choiceCat in
                            Button(action: {
                                showConversationView.toggle()
                                self.choiceCat = choiceCat
                                isEditing = false
                                UserDefaults.standard.set(choiceCat.id, forKey: "CatId")
                            }, label: {
                                // SearchCatCell(catsSearchedArr: selectedCatArr)
                            })
                        }
                    }
                }
            }
        }
    }
}

