//
//  TopPartDetailView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/21.
//

import SwiftUI
import Kingfisher

struct TopPartDetailView: View {
    @EnvironmentObject var shop: Shop
    @State private var isAnimating: Bool = false
    // @ObservedObject var viewModel:StrayCatsItemViewModel
    // MARK: - PROPERTY
    
    // @EnvironmentObject var shop: Shop
    // @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center, spacing: 6, content: {
                // PRICE
                VStack(alignment: .leading, spacing: 6, content: {
                    Text("고양이 이름은")
                        .fontWeight(.semibold)
                    
                    Text(shop.selectedProduct?.name ?? "")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .scaleEffect(1.35, anchor: .leading)
                    // DESCRIPTION
                    
                    
                    Text(shop.selectedProduct?.name ?? "")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    
                })
                .offset(y: isAnimating ? -50 : -75)
                
                
                // Spacer()
                
                KFImage(URL(string: shop.selectedProduct?.image ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250,height: 250)
                    .background(Color.white) // 하얀 배경
                    .clipShape(Capsule())
                    .shadow(color:Color(.systemGray6), radius: 6, x: 0.0, y: 0.0)
                    .offset(y: isAnimating ? 0 : -35)
                
                
                
            }) //: HSTACK
        }
        .zIndex(0)
        .ignoresSafeArea(.all, edges: .all)
        .onAppear(perform: {
            withAnimation(.easeOut(duration: 0.75)) {
                isAnimating.toggle()
            }
        })
    }
}

// #Preview {
//     TopPartDetailView(viewModel: StrayCatsItemViewModel())
// }
