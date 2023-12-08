//
//  WatchCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI
import Kingfisher

struct AddedCatListView: View {
    
    // @ObservedObject var viewModel = WatchCellViewModel()
    // @EnvironmentObject var model:AuthViewModel
    // @State var arrOfCats:[CatRealmModel] = []
    @State private var isDataLoaded = false
    @ObservedObject var catModel = WatchCellViewModel()
    @Binding var showTopCustomView: Bool
    var watchCatList:[Cats]?
    @State private var isLoading = true // 딜레이
    
    @State private var selectedCat: Cats?
    // @State private var showAddEventView = false
    //냥이 추가 btn
    var goToAddViewButton: some View {
        NavigationLink(
            destination: AddCatView(showTopCustomView: $showTopCustomView, catViewModel: AddCatViewModel())) {
                
                HStack {
                    Image(systemName: "waveform.path.badge.plus")
                        .foregroundColor(.white)
                        .padding(.leading,5)
                    
                    Text("냥이추가")
                        .foregroundColor(.white)
                        .padding(.leading,5)
                        .frame(width: 70, height: 36)
                }
                .background(
                    Capsule()
                        .fill(Color.primaryColor)
                )
                .padding(.bottom, 10)
                
            }}
    
    var body: some View {
        ZStack(alignment:.bottom){
            ScrollView{
                if !isLoading {
                    VStack{
                        VStack(spacing: 1) {
                            if let selectedCat = selectedCat {
                                NavigationLink(
                                    destination: AddEventView(showTopCustomView: $showTopCustomView),
                                    label: {}
                                )
                            }
                            if !catModel.filteredCats.isEmpty {
                                ForEach(catModel.filteredCats) { userCat in //데이터 파생
                                    WatchCatCell(viewModel: WatchItemCellModel(userCat))
                                        .padding(5)
                                        
                                }
                            } else {
                                
                                ZStack{
                                    Image("illustration-no1")
                                        .resizable()
                                        .frame(width: .infinity , height: 400)
                                    Text("아직 저장된 고양이가 없네요 \n 고양이 추가로 \n 나만의 고양이 보관함을 만들어 보세요")
                                        .font(.footnote)
                                        .padding(5)
                                        .background(Color.primaryColor)
                                        .cornerRadius(12)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                    
                                }.padding(.top, 20)
                                
                                
                            }
                        }
                        
                        
                    }
                }else {
                    ZStack {
                        Spacer() // Push content to the top
                        ProgressView("Loading…")
                            .progressViewStyle(CircularProgressViewStyle())
                        Spacer() // Push content to the bottom
                    }
                    .frame(width: 500, height: 500)
                }
                
            }
            
            goToAddViewButton
                .padding(.bottom, 20)
        }
        .onAppear {
            // 여기서 모델 호출 또는 다른 초기화 작업을 수행합니다.
            catModel.fetchMatchCat()
            print("임마 : \(catModel.filteredCats)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isLoading = false // Set isLoading to false when data is loaded
            }
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