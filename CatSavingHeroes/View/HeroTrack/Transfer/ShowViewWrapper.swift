//
//  ShowViewWrapper.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import SwiftUI
import MapKit
import RealmSwift

struct ShowViewWrapper: UIViewControllerRepresentable {
    // @Binding var isShowingUIKitView: Bool
    @Binding var mapView: MKMapView
    
    // func makeUIViewController(context: Context) -> ShowViewController {
    //     return ShowViewController()
    // }
    
    func makeUIViewController(context: Context) -> ShowViewController {
        let showViewController = ShowViewController()
        showViewController.mapView = mapView
        // showViewController.setupButton() // 버튼을 설정하는 함수 호출
        return showViewController
    }
    
    func updateUIViewController(_ uiViewController: ShowViewController, context: Context) {
        
    }
}
struct ShowViewView: View {
    @State private var mapView = MKMapView()
        
        var body: some View {
            NavigationView {
               
                VStack {
                    ShowViewWrapper(mapView: $mapView)
                        
                }
                    .navigationBarTitle("Hero Track")
            }
        }
}


// #Preview {
//     ShowViewWrapper(mapView: $mapView)
// }
