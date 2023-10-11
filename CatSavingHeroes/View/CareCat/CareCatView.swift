//
//  CareCatView.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/08.
//

import SwiftUI

struct CareCatView: View {
    @EnvironmentObject var locationManager: AddressManager
    var body: some View {
        VStack {
            MapViewCoordinator(locationManager: locationManager)
        }
        .padding()
    }
}
struct MapViewCoordinator: UIViewRepresentable {
    @ObservedObject var locationManager: AddressManager
    
    func makeUIView(context: Context) -> some UIView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

#Preview {
    CareCatView()
}
