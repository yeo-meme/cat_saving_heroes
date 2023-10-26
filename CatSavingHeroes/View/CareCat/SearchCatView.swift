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
    // @Binding var selectedCatArr: [CatRealmModel] // 선택한 셀의 내용을 저장할 변수
    // @Binding var selectedCat: CatRealmModel? // 선택한 셀의 내용을 저장할 변수
    
    
    @Binding var selectedCatArr: [Cats] // 선택한 셀의 내용을 저장할 변수
    @Binding var selectedCat: Cats? // 선택한 셀의 내용을 저장할 변수
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                ScrollView {
                    VStack(spacing: 1) {
                        ForEach(selectedCatArr) { user in
                            Button(action: {
                                showConversationView.toggle()
                                // self.selectedCatArr = selectedCatArr
                                self.selectedCat = user
                                print("selectedCat :\( user)")
                                isEditing = false
                                // mode.wrappedValue.dismiss()
                            }, label: {
                                SearchCatCell(catsSearchedArr: $selectedCatArr)
                            })
                        }
                    }
                  
                }
            }
        }
        // .showErrorMessage(showAlert: $viewModel.showErrorAlert, message: viewModel.errorMessage)
    }
    
    
}

// #Preview {
//     SearchCatView(showConversationView: .constant(<#T##value: Bool##Bool#>), selectedCatArr: <#Binding<[CatRealmModel]>#>, selectedCat: <#Binding<CatRealmModel?>#>)
// }
