//
//  TakeCareOfCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI

struct TakeCareOfCatView: View {
    // @State private var isDataLoaded = false
    // @ObservedObject var catModel = WatchCellViewModel()
    // var watchCatList:[Cats]?
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: 1) {
                    // if !catModel.filteredCats.isEmpty {
                    //     ForEach(catModel.filteredCats) { userCat in //데이터 파생
                    //         WatchCatCell(viewModel: WatchItemCellModel(userCat))
                    //     }
                    // } else {
                        
                        ZStack{
                            Image("illustration-no3")
                                   .resizable()
                                   .frame(width: .infinity , height: 400)
                            Text("내가 돌보는 냥이를 \n 북마크해서 \n 돌봄에서 볼 수 있어요")
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
        }
        .onAppear{
            viewModel.matchUserInterestCatLoad()
            // 여기서 모델 호출 또는 다른 초기화 작업을 수행합니다.
            
            // print("임마 : \(catModel.filteredCats)")
        }
    }

#Preview {
    TakeCareOfCatView()
}
