//
//  CatDetailView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/12.
//

import SwiftUI

struct CatDetailView: View {
    // @State var arrCat:[Cats]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            // NAVBAR
            NavigationBarDetailView()
                .padding(.horizontal)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            // HEADER
            // HeaderDetailView()
            //   .padding(.horizontal)
            
            // DETAIL TOP PART
            TopPartDetailView()
                .padding(.horizontal)
                .zIndex(1)
            FavouriteDetailView()
                .padding(.horizontal)
            
            ZStack {
                Rectangle()
                    .fill(Color.black) // 검은색 배경
                    .frame(width: .infinity, height: 250) // 원하는 크기로 설정
                    .cornerRadius(10) // 원하는 모서리 반경 설정
                    .shadow(color: .gray, radius: 3, x: 0, y: 0) // 그림자 효과
                    .padding(.trailing)
                    .padding(.leading)
             
                
                // 흰색 배경의 리스트
                // List {
                //     Text("리스트 아이템 1")
                //     Text("리스트 아이템 2")
                //     Text("리스트 아이템 3")
                //     
                // }
                // .background(Color.white) // 흰색 배경
                // .cornerRadius(10) // 모서리 반경 설정
                // .padding(10) // 여백 추가
                
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
                
                // HStack{
                //     Button(action: {
                //         
                //     }, label: {
                //         Text("이벤트추가")
                //             .font(.headline)
                //             .frame(width: 150, height: 50)
                //             .background(Color.primaryColor)
                //             .foregroundColor(Color.white)
                //             .overlay(
                //                 RoundedRectangle(cornerRadius: 8)
                //                     .stroke(Color.gray, lineWidth: 1)
                //             )
                //             .padding(0)
                //     })
                //     // .disabled(isButtonClicked)
                //     .shadow(color:Color(.systemGray6), radius: 6, x: 0.0, y: 0.0)
                //     
                //     Button(action: {
                //         
                //     }, label: {
                //         Text("이벤트추가")
                //             .font(.headline)
                //             .frame(width: 150, height: 50)
                //             .background(Color.primaryColor)
                //             .foregroundColor(Color.white)
                //             .overlay(
                //                 RoundedRectangle(cornerRadius: 8)
                //                     .stroke(Color.gray, lineWidth: 1)
                //             )
                //             .padding(0)
                //     })
                //     // .disabled(isButtonClicked)
                //     .shadow(color:Color(.systemGray6), radius: 6, x: 0.0, y: 0.0)
                // }
                // .offset(y: 40)
                
            }
            
            // .padding(.vertical, 5)
            
            // DETAIL BOTTOM PART
            // VStack(alignment: .center, spacing: 0, content: {
            //     // RATINGS + SIZES
            //     // RatingsSizesDetailView()
            //     //   .padding(.top, -20)
            //     //   .padding(.bottom, 10)
            //
            //
            //
            //     // QUANTITY + FAVOURITE
            //
            //
            //     // ADD TO CART
            //     // AddToCartDetailView()
            //     // .padding(.bottom, 20)
            // }) //: VSTACK
            // .padding(.horizontal)
            // .background(
            //     Color.white
            //         .clipShape(CustomShape())
            //         .padding(.top, -105)
            // )
        }) //: VSTACK
        .zIndex(0)
        // .ignoresSafeArea(.all, edges: .all)
        
    }
}

#Preview {
    CatDetailView()
}
