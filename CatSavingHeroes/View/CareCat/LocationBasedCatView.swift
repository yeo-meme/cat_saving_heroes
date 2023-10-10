//
//  FavoriteView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI
import RealmSwift
import CoreLocation
import MapKit
// Realm 모델 클래스
// class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//     @Published var lastLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
//     private var locationManager = CLLocationManager()
//     
//     override init() {
//         super.init()
//         locationManager.delegate = self
//         locationManager.desiredAccuracy = kCLLocationAccuracyBest
//     }
//     
//     func startUpdatingLocation() {
//         locationManager.requestWhenInUseAuthorization()
//         locationManager.startUpdatingLocation()
//     }
//     
//     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//         if let newLocation = locations.last?.coordinate {
//             lastLocation = newLocation
//         }
//     }
// }
struct LocationBasedCatView: View {
    // @EnvironmentObject var locationManager: LocationManager
    @State private var isRecording = false
    // @State private var locationRecords: [LocationRecord] = []

    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Button(action: {
                        // 위치 기록을 Realm에 저장
                        // if isRecording {
                        //     
                        //     // 위치 기록을 Realm에 저장
                        //     let locationRecord = LocationRecord()
                        //     locationRecord.latitude = locationManager.lastLocation.latitude
                        //     locationRecord.longitude = locationManager.lastLocation.longitude
                        //     
                        //     do {
                        //         let realm = try Realm()
                        //         try realm.write {
                        //             realm.add(locationRecord)
                        //         }
                        //         print("realm기록하였음")
                        //     } catch {
                        //         print("Error saving location: \(error.localizedDescription)")
                        //     }
                        // }
                    }) {
                        Text("장소추가")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    
                    Button {
                        // fetchLocationRecords()
                    } label: {
                        Text("불러오기")
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("메모 추가")
                    })
                }
            }
        }
        .padding(.horizontal, 24)
    }
    
    // func fetchLocationRecords() {
    //     do {
    //         let realm = try Realm()
    //         let locationRecords = realm.objects(LocationRecord.self)
    //         print("불러오기 : \(locationRecords)")
    //     } catch {
    //         print("Error fetching location records: \(error.localizedDescription)")
    //     }
    // }
}






