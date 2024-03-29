//
//  TakeCareOfCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI

struct WatchingCatView: View {
    // @State private var isDataLoaded = false
    @ObservedObject var viewModel = TakeCareOfCatViewModel()
    // var watchCatList:[Cats]?
    @State private var isLoading = true // 딜레이
    
    @Binding var showingEventAddView : Bool
    @Binding var path:[CatsNavigation]
    var body: some View {
        ZStack{
            ScrollView{
                if !isLoading {
                    VStack(spacing: 1) {
                        if !viewModel.filterCatsList.isEmpty{
                            VStack{
                                ForEach(viewModel.filterCatsList) { userCat in
                                    NavigationLink(value: CatsNavigation.care) {
                                        WatchingCellView(viewModel: WatchingCellViewModel(userCat), isLoading: $isLoading)
                                            .padding(5)
                                            .onTapGesture {
                                                showingEventAddView = true
                                                path.append(CatsNavigation.care)
                                            }
                                    }
                                    .navigationDestination(for: CatsNavigation.self) { screen in
                                        switch screen {
                                        case .care: CatInfoDetailView()
                                        }
                                    }
                                }
                            }
                        } else {
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
                } else {
                    ZStack {
                        Spacer() // Push content to the top
                        ProgressView("Loading…")
                            .progressViewStyle(CircularProgressViewStyle())
                        Spacer() // Push content to the bottom
                    }
                    .frame(width: 500, height: 500)
                }
            }
        }
  
        .onAppear{
            viewModel.matchUserInterestCatLoad()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isLoading = false // Set isLoading to false when data is loaded
            }
        }
    }
}
