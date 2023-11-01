//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy
//

import SwiftUI
import Kingfisher

struct StrayCatsItemView: View {
    
    // @ObservedObject var viewModel = StrayCatsItemViewModel
    
    let product: Product
   // var modifiedCat:Cats?
    
    
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
            // Text(modifiedCat?.id ?? "")
            // .fontWeight(.semibold)
            // .foregroundColor(.gray)
        }) //: VSTACK
      
    }
}


struct StrayCatsItemView2: View {
    
    @ObservedObject var viewModel:StrayCatsItemViewModel
    
   // var modifiedCat:Cats?
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
          // PHOTO
            ZStack (alignment:.leading){
              // Image(cats.cat_photo)
                KFImage(URL(string: viewModel.strayArrCats.cat_photo))
              .resizable()
              .scaledToFit()
              .padding(10)
          } //: ZSTACK
            .background(Color(red: viewModel.strayArrCats.color[0] ?? 0.0 , green: viewModel.strayArrCats.color[1] ?? 0.0, blue: viewModel.strayArrCats.color[2] ?? 0.0))
          .cornerRadius(12)
          
          // NAME
            Text(viewModel.strayArrCats.name)
            .font(.title3)
            .fontWeight(.black)
          
          // PRICE
            // Text(modifiedCat?.id ?? "")
            // .fontWeight(.semibold)
            // .foregroundColor(.gray)
        }) //: VSTACK
   
    }
}
