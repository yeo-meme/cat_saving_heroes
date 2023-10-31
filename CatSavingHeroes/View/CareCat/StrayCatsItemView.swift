//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy
//

import SwiftUI
import Kingfisher

struct StrayCatsItemView: View {
    
    // @ObservedObject var viewModel:StrayCatsItemViewModel
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
          // PHOTO
          ZStack {
            Image(product.image)
              .resizable()
              .scaledToFit()
              .padding(10)
          } //: ZSTACK
          .background(Color(red: product.red, green: product.green, blue: product.blue))
          .cornerRadius(12)
          
          // NAME
          Text(product.name)
            .font(.title3)
            .fontWeight(.black)
          
          // PRICE
          Text(product.formattedPrice)
            .fontWeight(.semibold)
            .foregroundColor(.gray)
        }) //: VSTACK
            // VStack(alignment: .leading, spacing: 6){
            //     NavigationLink(destination: CatDetailView(viewModel: StrayCatsItemViewModel(viewModel.strayArrCats))) {
            //             // PHOTO
            //             ZStack() {
            //                 KFImage(URL(string: viewModel.strayArrCats.cat_photo))
            //                     .resizable()
            //                     // .scaledToFit()
            //                     .frame(width: 150, height: 150) // 원하는 크기로 설정
            //                     .cornerRadius(12)
            //                     .padding(10)
            //             }.cornerRadius(12)
            //             
            //             
            //             
            //             Text(viewModel.strayArrCats.name)
            //                 .font(.title3)
            //                 .fontWeight(.black)
            //             
            //             Text(viewModel.strayArrCats.gender)
            //                 .fontWeight(.semibold)
            //                 .foregroundColor(.gray)
            //         } //: VSTACK
            // }
    }
}
