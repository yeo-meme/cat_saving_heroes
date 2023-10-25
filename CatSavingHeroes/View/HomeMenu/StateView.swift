//
//  StateView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/23.
//

import SwiftUI
import SlidingTabView
import Kingfisher
import Alamofire


struct StateView: View {
    @Binding var presentSideMenu: Bool
    @Binding var presentNavigationBar: Bool
    @State private var tabIndex = 0
    @EnvironmentObject var viewModel : AuthViewModel
    @State var tag:Int? = nil
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 1) {
                    HStack(spacing: 12) {
                        if let imageUrl = viewModel.currentUser?.profileImageUrl {
                            KFImage(URL(string:imageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .padding(.leading)
                        } else {
                            Image("profile1")
                            // .resizable()
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
                    // }//:User Profile
                    
                    VStack{
                        SlidingTabView(selection: $tabIndex, tabs: ["보는냥","관심냥","돌봄냥"], selectionBarColor: Color.primaryColor)
                        if tabIndex == 0 {
                            WatchCatView()
                        } else if tabIndex == 1 {
                            Text("2")
                        } else if tabIndex == 2 {
                            Text("3")
                        }
                    }.zIndex(0)
                    ZStack(alignment: .bottom){
                        goToAddViewButton
                    }.padding(.bottom, 10)
                }
                .onAppear{
                    // deleteAllMongo()
                    fetchCatsCommon()
                }
                .padding(.top, -300)
            }
        }
    }
    
    func deleteAllMongo() {
        AF.request(CAT_DELETE_API_URL, method: .delete).response { response in
            if let error = response.error{
                print("Error: \(error)")
            }else {
                print("All todos deleted successfully")
            }}
    }
    func fetchCatsCommon() {
        
        AF.request(CAT_SELECT_API_URL, method: .get).responseDecodable(of: [Cats].self) { response in
             switch response.result {
             case .success(let value):
              print("성공 디코딩 : \(value)")
             case .failure(let error):
                 print("실패 디코딩 : \(error.localizedDescription)")
             }
         }
      }

    
    var goToAddViewButton: some View {
        NavigationLink(
            destination: AddCatView(catViewModel: AddCatViewModel())) {
                HStack {
                    Image(systemName: "waveform.path.badge.plus")
                        .foregroundColor(.white)
                        // .padding(.leading, 5)
                    
                    Text("냥이추가")
                        .foregroundColor(.white)
                        .padding(.all, 5)
                        .frame(width: 55, height: 40)
                    
                }
                .background(
                    Capsule()
                        .fill(Color.primaryColor)
                )
            }
    }}




// #Preview {
//     StateView( presentSideMenu: .constant(false), presentNavigationBar: .constant(false), catViewModel: )
// }
