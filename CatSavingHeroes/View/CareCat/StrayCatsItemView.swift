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
                VStack(alignment: .leading, spacing: 6){
                    if viewModel.strayArrCats != nil {
                        NavigationLink(destination: CatDetailView()) {
                    // PHOTO
                    ZStack {
                        // KFImage(URL(string: viewModel.strayArrCats.cat_photo))
                        //     .resizable()
                        //     .scaledToFit()
                        //     .cornerRadius(12)
                        //     .padding(10)
                        
                    }.cornerRadius(12)
                                
                   
                    
                    // Text(viewModel.strayArrCats.name)
                    //     .font(.title3)
                    //     .fontWeight(.black)
                    // 
                    // Text(viewModel.strayArrCats.gender)
                    //     .fontWeight(.semibold)
                    //     .foregroundColor(.gray)
                } //: VSTACK
            }
        }
    }
}
