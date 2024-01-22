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
    // @Binding var presentNavigationBar: Bool
    
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel : AuthViewModel
    
    @Binding var path:[CatsNavigation]
    @Binding var presentSideMenu: Bool
    
    @State private var showSheet = false
    @State private var tabIndex = 0
    @State var tag:Int? = nil
    @State var isDataLoaded = false
    @State private var selectedTabIndex = 0
    @State private var showingEventAddView = false
    @State private var selectedNavigation: CatsNavigation?
    
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack(alignment:.bottomTrailing){
                VStack{
                    // NavigationLink(
                    //     destination: SettingsView(viewModel.currentUser ?? MOCK_USER),
                    //     label: {
                    //:User Profile
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
                    
                    
                    
                    //custom tabbar 시작
                    SlidingTabBar(tabs: ["추가냥","왓치냥"], selectedTabIndex: $selectedTabIndex)
                        .background(Color.gray.opacity(0.1))
                    
                    // Spacer()
                    
                    switch selectedTabIndex{
                    case 0:
                        AddedCatListView()
                    case 1:
                        WatchingCatView(showingEventAddView: $showingEventAddView, path: $path)
                    default:
                        Text("default")
                    }
                    Spacer()
            
                    
                    
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
        }
    }
}

struct SlidingTabBar:View {
    
    let tabs:[String]
    @Binding var selectedTabIndex: Int
    @State private var tabBarOffset: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<tabs.count, id:\.self) { index in
                        Text(tabs[index])
                            .font(.headline)
                            .foregroundColor(selectedTabIndex == index ? .blue : .black)
                            .onTapGesture {
                                withAnimation{
                                    selectedTabIndex = index
                                    tabBarOffset = UIScreen.main.bounds.width / CGFloat(tabs.count) * CGFloat(index)
                                }
                            }
                    }
                }
                .frame(height:44)
                .padding()
            }
            
            Rectangle()
                .fill(Color.blue)
                .frame(width: UIScreen.main.bounds.width / CGFloat(tabs.count),height: 3)
                .offset(x: tabBarOffset)
                .animation(.easeInOut)
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
