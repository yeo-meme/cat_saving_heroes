//
//  WatchCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI
import Kingfisher

struct AddedCatListView: View {
    @EnvironmentObject var model:AuthViewModel
    @ObservedObject var catModel = WatchCellViewModel()
    
    @Binding var path:[CatsNavigation]
    @Binding var showingEventAddView:Bool
    
    @State private var isDataLoaded = false
    @State private var isLoading = true // 딜레이
    @State private var selectedCat: Cats?
    @State private var selectedNavigation: CatsNavigation? = .care
    
   
    
    var watchCatList:[Cats]?
    //냥이 추가 btn
    var goToAddViewButton: some View {
        NavigationLink(
            destination: AddCatView( catViewModel: AddCatViewModel())) {
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
        
        // ZStack(alignment:.bottom){
        VStack{
            if !isLoading {
                    ForEach(catModel.filteredCats) { userCat in //데이터 파생
                        NavigationLink(value: CatsNavigation.care, label: {
                            WatchCatCell(viewModel: WatchItemCellModel(userCat))
                                .padding(5)
                                .onTapGesture {
                                    showingEventAddView = true
                                    path.append(CatsNavigation.care)
                                }
                        })
                        .navigationDestination(for: CatsNavigation.self) { screen in
                            switch screen {
                            case .care: EventAddView()
                            }
                        }
                }
                // if !catModel.filteredCats.isEmpty {
                //
                // } else {
                //     noCatsView
                // }
                // }:VSTACK
                
            } else {
                loadingView
            }
            goToAddViewButton
                .padding(.bottom, 20)
        }
        .onAppear {
            model.showTopCustomView = true
            // 여기서 모델 호출 또는 다른 초기화 작업을 수행합니다.
            // catModel.fetchMatchCat()
            print("임마 : \(catModel.filteredCats)")
            
            // DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isLoading = false // Set isLoading to false when data is loaded
            // }
        }
        
        
    }
}


@ViewBuilder
private var noCatsView: some View {
    ZStack {
        Image("illustration-no1")
            .resizable()
            .frame(width: .infinity, height: 400)
        
        Text("아직 저장된 고양이가 없네요 \n 고양이 추가로 \n 나만의 고양이 보관함을 만들어 보세요")
            .font(.footnote)
            .padding(5)
            .background(Color.primaryColor)
            .cornerRadius(12)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
    .padding(.top, 20)
}


@ViewBuilder
private var loadingView: some View {
    ZStack {
        Spacer()
        ProgressView("로딩 중....")
            .progressViewStyle(CircularProgressViewStyle())
        Spacer()
    }
    .frame(width: 500, height: 500)
}
