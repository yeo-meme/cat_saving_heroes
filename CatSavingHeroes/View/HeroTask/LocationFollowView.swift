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
    
    @Binding var presentSideMenu: Bool
    @State private var tabIndex = 0
    var body: some View {
        
        
        NavigationView{
            VStack{
                SlidingTabView(selection: $tabIndex, tabs: ["영웅업무시작","영웅일지"], selectionBarColor: .green)
                Spacer()
                if tabIndex == 0 {
                    TrackingHeroView(weatherModel: WeatherViewModel())
                } else if tabIndex == 1 {
                    HeroCalendarView()
                }
                Spacer()
            }
            .navigationBarItems(leading: Text("영웅일지"),
                trailing: NavigationMenuView(presentSideMenu: $presentSideMenu))
            // .navigationTitle("영웅일지")
        }
        
    }
}


