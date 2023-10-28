//
//  LocationView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI
import MapKit
import CoreLocation
import SlidingTabView


struct LocationFollowView: View {
    @State var isShowingSideMenu = false
    @Binding var presentSideMenu: Bool
    @State var selectedSideMenuTab = 0
    @State private var tabIndex = 0
    var body: some View {
        
        
        NavigationView{
            ZStack{
                VStack{
                    // NavigationBarView(presentNavigationBar: $presentSideMenu)
                    //     .padding(.horizontal, 15)
                    //     .padding(.bottom)
                    // // .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    //     .background(Color.white)
                    //     .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                    
                    SlidingTabView(selection: $tabIndex, tabs: ["영웅업무시작","영웅일지"], selectionBarColor: .green)
                    Spacer()
                    if tabIndex == 0 {
                        TrackingHeroView(weatherModel: WeatherViewModel())
                    } else if tabIndex == 1 {
                        HeroCalendarView()
                    }
                    Spacer()
                }
                // .navigationBarItems(leading: Text("영웅일지"),
                //                     trailing: NavigationMenuView(presentSideMenu: $presentSideMenu))
                // .navigationTitle("영웅일지")
                // SideMenu(isShowing: $isShowingSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $isShowingSideMenu)))
                
               
            }
            
        }
    }
}


