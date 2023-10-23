//
//  StateView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI
import SlidingTabView
import Kingfisher

struct StateView: View {
    @Binding var presentSideMenu: Bool
    @State private var tabIndex = 0
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        VStack{
            VStack(spacing: 1) {
                HStack(spacing: 12) {
                    // KFImage(URL(string: user.profileImageUrl))
                    // Image("OIGG")
                    //     .resizable()
                    //     .scaledToFill()
                    //     .frame(width: 48, height: 48)
                    //     .clipShape(Circle())
                    //     .padding(.leading)
                    
                    if let imageUrl = viewModel.currentUser?.profileImageUrl {
                        KFImage(URL(string:imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                            .padding(.leading)
                    } else {
                        Image("profile1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                            .padding(.leading)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        if let userName = viewModel.currentUser?.name{
                            
                            Text(userName)
                                .bold()
                                .foregroundColor(.black)
                            
                        } else {
                            Text("지나가는 행인")
                                .bold()
                                .foregroundColor(.black)
                        }
                        Text("user.status.title")
                            .foregroundColor(Color(.systemGray))
                    }
                    Spacer()
                }
                .frame(height: 70)
                .background(Color.white)
                
                CustomDivider(leadingSpace: 76)
            }
            
            NavigationView{
                VStack{
                    SlidingTabView(selection: $tabIndex, tabs: ["보는냥","관심냥","돌봄냥"], selectionBarColor: Color.primaryColor)
                    Spacer()
                    if tabIndex == 0 {
                        Text("0")
                    } else if tabIndex == 1 {
                        Text("2")
                    } else if tabIndex == 2 {
                        Text("3")
                    }
                    Spacer()
                }
                // .navigationBarItems(leading: Text("영웅일지"),
                //     trailing: NavigationMenuView(presentSideMenu: $presentSideMenu))
                // .navigationTitle("영웅일지")
            }
        }
    }
}

#Preview {
    StateView(presentSideMenu: .constant(false))
}
