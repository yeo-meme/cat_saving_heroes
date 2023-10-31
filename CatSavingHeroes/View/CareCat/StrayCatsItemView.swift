//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy
//

import SwiftUI
import Kingfisher

struct StrayCatsItemView: View {
    
    // @ObservedObject var viewModel = StrayCatsALLViewModel()
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
