//
//  WatchCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI
import Kingfisher

struct WatchCatView: View {
    
    @ObservedObject var viewModel = WatchCellViewModel()
    // @EnvironmentObject var model:AuthViewModel
    // @State var arrOfCats:[CatRealmModel] = []
    @State private var isDataLoaded = false
    @ObservedObject var catModel = WatchCellViewModel()
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: 1) {
                    ForEach(catModel.arrUsercats) { userCat in //데이터 파생
                        WatchCatCell(viewModel: WatchItemCellModel(userCat))
                    }
                }
            }
        }
        .onAppear {
            // 여기서 모델 호출 또는 다른 초기화 작업을 수행합니다.
            catModel.fetchMatchCat()
            print("임마 : \(catModel.arrUsercats)")
        }
    }
}
//
// VStack{
//
//         HStack(spacing: 12) {
//             ForEach(arrOfCats) { userCat in
//                 if userCat.profileImage != nil {
//                     KFImage(URL(string:userCat.profileImage))
//                         .resizable()
//                         .scaledToFill()
//                         .frame(width: 48, height: 48)
//                         .clipShape(Circle())
//                         .padding(.leading)
//                 } else {
//                     Image("profile1")
//                         .resizable()
//                         .aspectRatio(contentMode: .fill)
//                         .frame(width: 48, height: 48)
//                         .clipShape(Circle())
//                         .padding(.leading)
//                 }//: 캣이미지
//                 VStack(alignment: .leading, spacing: 4) {
//                     if userCat.name != nil {
//                         Text(userCat.name)
//                             .bold()
//                             .foregroundColor(.black)
//                     } else {
//                         Text("지나가는 행인")
//                             .bold()
//                             .foregroundColor(.black)
//                     }
//                     Text("user.status.title")
//                         .foregroundColor(Color(.systemGray))
//                 }//:catName
//                 Spacer()
//             }
//
//             }
//             .frame(height: 70)
//             .background(Color.white)
//             CustomDivider(leadingSpace: 76)
//             }
// func realmCall() {
//
//     if let userId = AuthViewModel.shared.currentUser?.uid {
//         print("user ID : \(userId)")
//
//         let arr = RealmHelper.shared.read(CatRealmModel.self)
//         print("user ID get CatRealmModel : \(arr)")
//
//         for aa in arr {
//             if aa.user_id == userId {
//                 print("datarealmCall All: \(aa.name)")
//             }
//
//         }
//         arrOfCats = RealmHelper.shared.getCatByUserId(userId: userId)
//         print("datarealmCall: \(arrOfCats)")
//         finishedLoad = true
//     }
// }

// #Preview {
//     WatchCatView()
// }
