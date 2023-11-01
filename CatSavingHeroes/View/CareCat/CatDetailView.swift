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
        // NAVBAR
        NavigationBarDetailView()
          .padding(.horizontal)
          .ignoresSafeArea(.all)
          // .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
          .offset(y:-40)

        // HEADER
        HeaderDetailView()
          .padding(.horizontal)
          .offset(y:-30)
        
        // DETAIL TOP PART
        TopPartDetailView()
          .padding(.horizontal)
          .zIndex(1)
        
          // DETAIL BOTTOM PART
                     VStack(alignment: .center, spacing: 0, content: {
                             FavouriteDetailView()
                                 .padding(.horizontal)// RATINGS + SIZES
                             // .offset(x:-20, y:-30)
                             //고양이 카드
                             ZStack {
                                 Image("Folder")
                                     .resizable()
                                     .frame(width: .infinity, height: 270) // 원하는 크기로 설정
                                        .cornerRadius(10) // 원하는 모서리 반경 설정
                                        .shadow(color: Color(.systemGray4), radius: 3, x: 3, y: 3)
                                        .padding(.trailing)
                                        .padding(.leading)
                                 
                                     Text("History")
                                         .foregroundColor(.white) // 텍스트 색상 설정
                                         .font(Font.system(size: 17).bold()) // 폰트 크기 및
                                         .cornerRadius(10) // 모서리 반경 설정
                                         .fontWeight(.bold) // 텍스트에 볼드 스타일 추가
                                         .offset(x:-115, y:-115)
                                 
                                 //고양이 카드
                                 ScrollView(.vertical, showsIndicators: false) {
                                     VStack(spacing:1){
                                         let aaa = ["1","2","3","4","5"]
                                         ForEach(aaa, id: \.self) { message in
                                             CareDetailListItemCell()
                                                 .padding(.top,10)
                                                 .padding(.bottom,10)
                                         }
                                     }
                                 }.frame(height: 170)
                                     .padding(.trailing)
                                     .padding(.leading)
                             }//: 고양이 카드
                             .offset(y:-30)
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



// QUANTITY + FAVOURITE
// QuantityFavouriteDetailView()
// .padding(.vertical, 10)

// ADD TO CART
// AddToCartDetailView()
// .padding(.bottom, 20)
