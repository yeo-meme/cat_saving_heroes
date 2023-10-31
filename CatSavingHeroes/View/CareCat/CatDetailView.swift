//
//  CatDetailView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/12.
//

import SwiftUI

struct CatDetailView: View {
    @EnvironmentObject var shop: Shop    // @ObservedObject var viewModel:StrayCatsItemViewModel
    @Binding var showTopCustomView : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
          
            
            NavigationBarDetailView()
              .padding(.horizontal)
              .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            
            // HEADER
            HeaderDetailView()
              .padding(.horizontal)
            
            // DETAIL TOP PART
            TopPartDetailView()
              .padding(.horizontal)
              .zIndex(1)
            
            // DETAIL TOP PART
            // TopPartDetailView(viewModel: StrayCatsItemViewModel(viewModel.strayArrCats))
            // CatTopPartDetailView()
            //     .padding(.horizontal)
            //     .zIndex(1)
            
            
            // DETAIL BOTTOM PART
            VStack(alignment: .center, spacing: 0, content: {
                VStack(alignment: .leading, content: {
                    FavouriteDetailView()
                        .padding(.horizontal)// RATINGS + SIZES
                        .padding(.top, -20)
                        .padding(.bottom, 10)
                })
                
              // RatingsSizesDetailView()
              //   .padding(.top, -20)
              //   .padding(.bottom, 10)
              
              // DESCRIPTION
              // ScrollView(.vertical, showsIndicators: false, content: {
              //   Text(shop.selectedProduct?.description ?? "sampleProduct.description")
              //     .font(.system(.body, design: .rounded))
              //     .foregroundColor(.gray)
              //     .multilineTextAlignment(.leading)
              // }) //: SCROLL
                
                //고양이 카드
                ZStack {
                    Rectangle()
                        .fill(Color.black) // 검은색 배경
                        .frame(width: .infinity, height: 320) // 원하는 크기로 설정
                        .cornerRadius(10) // 원하는 모서리 반경 설정
                        .shadow(color: .gray, radius: 3, x: 0, y: 0) // 그림자 효과
                        .padding(.trailing)
                        .padding(.leading)
                    
                    
                    
                    //고양이 카드
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing:1){
                            let aaa = ["1","2","3","4","5"]
                            ForEach(aaa, id: \.self) { message in
                                CareDetailListItemCell()
                            }
                        }
                    }.frame(height: 160)
                        .padding(.trailing)
                        .padding(.leading)
                    
                    
                }//: 고양이 카드
              
              // QUANTITY + FAVOURITE
              // QuantityFavouriteDetailView()
                // .padding(.vertical, 10)
              
              // ADD TO CART
              // AddToCartDetailView()
                // .padding(.bottom, 20)
            }) //: VSTACK
            .padding(.horizontal)
            .background(
              Color.white
                .clipShape(CustomShape())
                .padding(.top, -105)
            )
            
            
     
            
            
           
        }) //: VSTACK
        .zIndex(0)
        .ignoresSafeArea(.all, edges: .all)
        .background(
          Color(
            red: shop.selectedProduct?.red ?? 0.0,
            green: shop.selectedProduct?.green ?? 0.0,
            blue: shop.selectedProduct?.blue ?? 0.0
          ).ignoresSafeArea(.all, edges: .all)
        )
        .onAppear{
            self.showTopCustomView.toggle()
        }
        .onDisappear{
            self.showTopCustomView.toggle()
        }
    }
}
// 
// #Preview {
//     CatDetailView(viewModel: StrayCatsItemViewModel($viewModel.strayArrCats))
// }
