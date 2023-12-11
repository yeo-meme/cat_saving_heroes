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
    
    // @ObservedObject var viewModel: EditProfileViewModel
    @State private var showSheet = false
    
    @Environment(\.presentationMode) var mode
    @Binding var presentSideMenu: Bool
    // @Binding var presentNavigationBar: Bool
    @State private var tabIndex = 0
    @EnvironmentObject var viewModel : AuthViewModel
    @State var tag:Int? = nil
    
    @State var isDataLoaded = false
    
    
    var body: some View {
        // NavigationView{
            ZStack(alignment:.bottomTrailing){
                VStack{
                    // NavigationLink(
                    //     destination: SettingsView(viewModel.currentUser ?? MOCK_USER),
                    //     label: {
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
                                
                                if let userState = viewModel.currentUser?.status {
                                    if let status = Status(rawValue: userState.rawValue) {
                                        Text(status.title)
                                            .foregroundColor(Color(.systemGray))
                                    }
                                    
                                } else {
                                    Text("사용자의 상태입니다")
                                        .bold()
                                        .foregroundColor(.black)
                                }
                                
                            }
                            Spacer()
                        }
                        .frame(height: 70)
                        .background(Color.white)
                        CustomDivider(leadingSpace: 76)
                    }//:User Profile
                    // })
                    
                    SlidingTabView(selection: $tabIndex, tabs: ["추가냥","관심냥"], selectionBarColor: Color.primaryColor)
                    if tabIndex == 0 {
                        AddedCatListView()
                    } else if tabIndex == 1 {
                        InterestCatView()
                    }
                    //돌봄냥 리스트
                    // else if tabIndex == 2 {
                    //    TakeCareOfCatView()
                    // }
                }
                .onAppear {
                    // 여기서 모델 호출 또는 다른 초기화 작업을 수행합니다.
                    viewModel.fetchUser()
                }
            }
        // }
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
