//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy
//

import SwiftUI
import Kingfisher

struct StrayCatsItemView: View {
    
    @ObservedObject var viewModel:StrayCatsItemViewModel
  
    
    var body: some View {
        if let strayCat = viewModel.strayArrCats {
            NavigationLink(destination: CatDetailView()) {
                VStack(alignment: .leading, spacing: 6){
                    // PHOTO
                    ZStack {
                        // Image(product.image)
                        //     .resizable()
                        //     .scaledToFit()
                        //     .padding(10)
                        
                        // HStack(spacing: 12) {
                        KFImage(URL(string:strayCat.cat_photo))
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                        
                        // VStack(alignment: .leading, spacing: 4) {
                        //     Text(viewModel.strayArrCats?.name)
                        //         .font(.system(size: 18, weight: .semibold))
                        //         .foregroundColor(.black)
                        //
                        //     Text(viewModel.strayArrCats?.gender)
                        //         .font(.system(size: 15))
                        //         .foregroundColor(Color(.systemGray))
                        // }
                        // }
                    } //: ZSTACK
                    // .background(Color(red: product.red, green: product.green, blue: product.blue))
                    .cornerRadius(12)
                    
                    Text(strayCat.name)
                        .font(.title3)
                        .fontWeight(.black)
                    
                    Text(strayCat.gender)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                } //: VSTACK
             
            }
        }
            
    }
}
