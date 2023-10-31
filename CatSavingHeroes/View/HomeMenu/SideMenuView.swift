//
//  SideMenuView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import Kingfisher

//사이드바 메뉴
enum SideMenuRowType: Int, CaseIterable{
    case home = 0
    case favorite
    case chat
    case logout
    
    var title: String{
        switch self {
        case .home:
            return "홈으로"
        case .favorite:
            return "내 저장"
        case .chat:
            return "Chat"
        case .logout:
            return "로그아웃"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "home"
        case .favorite:
            return "favorite"
        case .chat:
            return "chat"
        case .logout:
            return "rectangle.portrait.and.arrow.right"
        }
    }
}

struct SideMenuView: View {
  
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    
    // @State private var isPresentingSecondView = false
    
    var body: some View {
        HStack {
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    ProfileImageView()
                        .frame(height: 140)
                        .padding(.bottom, 30)
                    
                        //사이드 바
                        ForEach(SideMenuRowType.allCases, id: \.self){ row in
                            RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                                selectedSideMenuTab = row.rawValue
                                presentSideMenu.toggle()
                                
                                if selectedSideMenuTab == 0 {
                                    print("row index 0  : \(row.rawValue)")
                                    NavigationLink(destination: CareCatView(showTopCustomView: .constant(false), presentSideMenu: $presentSideMenu)) {
                                                Label("새로운 화면", systemImage: "plus")
                                            }
                                } else if selectedSideMenuTab == 1 {
                                    print("row index 1 : \(row.rawValue)")
                                    NavigationLink(destination: HeroTrackView()) {
                                                Label("새로운 화면", systemImage: "plus")
                                            }
                                } else if selectedSideMenuTab == 3 {
                                    AuthViewModel.shared.signOut()
                                }
                             
                              
                            }
                        }
                        Spacer()
                    
                    
                       //날씨 api
                    
                }.padding(.top, 100)
                    .frame(width: 270)
                    .background(
                        Color.white
                    )
           
            }
            Spacer()
        }
        .background(.clear)
    }
    
    //여메메 이미지 뷰
    func ProfileImageView() -> some View{
        ZStack {
            VStack(alignment: .leading){
                Text("여메메")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                
                HStack{
                    VStack{
                        Text("2")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.blue.opacity(0.3))
                        Text("마이캣")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black.opacity(0.5))
                        
                    }
                    // VStack{
                    //     Text("6")
                    //         .font(.system(size: 14, weight: .semibold))
                    //         .foregroundColor(.blue.opacity(0.3))
                    //     Text("저장")
                    //         .font(.system(size: 14, weight: .semibold))
                    //         .foregroundColor(.black.opacity(0.5))
                    //     
                    // }
                    // VStack{
                    //     Text("8")
                    //         .font(.system(size: 14, weight: .semibold))
                    //         .foregroundColor(.blue.opacity(0.3))
                    //     Text("댓글")
                    //         .font(.system(size: 14, weight: .semibold))
                    //         .foregroundColor(.black.opacity(0.5))
                    //     
                    // }
                }
               
            }
            .padding(.trailing, 100)
            HStack{
                Spacer()
                
                if let imageUrl = viewModel.currentUser?.profileImageUrl {
                    KFImage(URL(string:imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80,height: 80)
                        .clipShape(Circle())
                        .padding(10)
                } else {
                    Image("profile1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(50)
                }
              
                
            
                // Image("profile-image")
                //     .resizable()
                //     .aspectRatio(contentMode: .fill)
                //     .frame(width: 80, height: 80)
                //     .cornerRadius(50)
            }
            .padding(.trailing, 30)
            
        }
    }
    
    //메뉴 row
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
            
            // self.presentSideMenu.toggle()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .purple : .white)
                        .frame(width: 5)
                    ZStack{
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        // .sheet(isPresented: $presentSideMenu) {
        //     CareCatView(presentNavigationBar: $presentSideMenu)
        //                }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .purple.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
}

