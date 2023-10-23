//
//  SearchBar.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/20.
//

import SwiftUI

// struct SearchBar: View {
//     @Binding var text: String
//     @Binding var isEditing: Bool
//     @Binding var isShowingSearchModal:Bool 
//     @State var catArr:[String]
//     @State var isCatArrfinish:Bool = false
//     
//     var body: some View {
//            
//                 HStack {
//                     TextField("Search...", text: $text)
//                         .padding(8)
//                         .padding(.horizontal, 32)
//                         .background(Color(.systemGroupedBackground))
//                         .cornerRadius(8)
//                         .overlay(
//                             Image(systemName: "magnifyingglass")
//                                 .foregroundColor(Color(.systemGray2))
//                                 .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                 .padding(.leading, 10)
//                         )
//                         .onSubmit {
//                             realmCall()
//                         }
//                     
//                     
//                     // .sheet(isPresented: $isShowingSearchModal) {
//                     //     SearchCatView(showConversationView: .constant(false), catNames:$catArr) }
//                     
//                    
//                     
//                     
//                     
//                     if isEditing {
//                         Button(action: {
//                             isEditing = false
//                             text = ""
//                             UIApplication.shared.endEditing()
//                         }, label: {
//                             Text("Cancel")
//                                 .foregroundColor(.black)
//                         })
//                         .padding(.trailing, 8)
//                     }
//         }
//                 // .onAppear{
//                 //     realmCall()
//                 // }
//  
//     }
//     func realmCall() {
//        
//         let cats = RealmHelper.shared.readCats(withName: text)
//         catArr = cats.map { $0.name }
//        print("리얼엠에서 부른 캣: \(cats)")
//         
//         $catArr.wrappedValue = catArr.map { $0 }
//         print("리얼엠에서 부른 캣 catArr.map: \($catArr)")
//       
//    }
// /}/ }

// 
// #Preview {
//     SearchBar()
// }
