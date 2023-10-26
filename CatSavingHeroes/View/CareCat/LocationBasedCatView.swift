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
    @EnvironmentObject var locationManager: Model
    @State private var isRecording = false
    @State private var locationRecords: [LocationRecord] = []

    @Binding var presentSideMenu: Bool
    
    var body: some View {
    
        VStack{
            HStack{
                HStack{
                    Button(action: {
                            let locationRecord = LocationRecord()
                            locationRecord.latitude = locationManager.lastLocation.latitude
                            locationRecord.longitude = locationManager.lastLocation.longitude

                        print("뭐지 : \(locationManager.lastLocation.latitude)")
                        do {
                                let realm = try Realm()
                                try realm.write {
                                    realm.add(locationRecord)
                                    print("realm기록하였음: Latitude: \(locationRecord.latitude), Longitude: \(locationRecord.longitude)")
                                }
                            } catch {
                                print("Error saving location: \(error.localizedDescription)")
                            }
                    }) {
                        Text("장소추가")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        fetchLocationRecords()
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
    
    func fetchLocationRecords() {
        // do {
        //     let realm = try Realm()
        //     let locationRecords = realm.objects(LocationRecord.self)
        //     print("불러오기 : \(locationRecords)")
        //     // 검색된 LocationRecord 객체의 값을 가져옵니다.
        //     for locationRecord in locationRecords {
        //         let latitude = locationRecord.latitude
        //         let longitude = locationRecord.longitude
        //         let timestamp = locationRecord.timestamp
        //         
        //         // 여기에서 가져온 값들을 사용하거나 출력할 수 있습니다.
        //         print("불러오기 Latitude: \(latitude), Longitude: \(longitude), Timestamp: \(timestamp)")
        //     }
        // } catch {
        //     print("Error fetching location records: \(error.localizedDescription)")
        // }
        
        // 트랙킹 Realm 객체를 읽습니다.
        let trackingEvents = RealmHelper.shared.read(Tracking.self)

        for trackingEvent in trackingEvents {
            if Double(trackingEvent.event_latitude) != 0.0{
                print("이벤트 캣 : \(trackingEvent.event_latitude)" )
            } else {
                print("이벤트 캣 0.0: \(trackingEvent.event_latitude)" )
            }
        }

        // 필터링된 값을 출력합니다.
      
    }
}





