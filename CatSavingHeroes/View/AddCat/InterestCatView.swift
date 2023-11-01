//
//  InterestCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI

struct InterestCatView: View {
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
                            Image("illustration-no2")
                                   .resizable()
                                   .frame(width: .infinity , height: 400)
                            Text("눈길이 가는 관심냥을 \n 추가하면 \n 관심냥에서 볼 수 있어요")
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
            // 여기서 모델 호출 또는 다른 초기화 작업을 수행합니다.
            // catModel.fetchMatchCat()
            // print("임마 : \(catModel.filteredCats)")
    }


#Preview {
    InterestCatView()
}
