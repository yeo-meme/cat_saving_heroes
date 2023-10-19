//
//  MainTabVeiw.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import MapKit
import Alamofire

struct MainTabView: View {
    @Binding var presentSideMenu: Bool
    @State private var showSheet = false
    @ObservedObject var weatherModel = WeatherManager()
    
    var body: some View {
        VStack{
            Spacer()
            
            
            
            Image("OIGG")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            
            Button(action: { self.showSheet = true },
                   label: { Text("Log out").font(.system(size: 18, weight: .semibold)) }
            )
            .foregroundColor(.red)
            .font(.system(size: 18))
            .frame(width: UIScreen.main.bounds.width, height: 50)
            .background(Color.white)
            .actionSheet(isPresented: $showSheet) {
                ActionSheet(title: Text("Log out"),
                            message: Text("로그아웃 하시면 자동로그인 풀려서 다시 로그인하셔야 해요"),
                            buttons: [
                                .destructive(Text("웅 로그아웃"), action: { AuthViewModel.shared.signOut() }),
                                .cancel(Text("그건 귀찮은데")) ])
            }
            Spacer()
        }
        
    }
}

// #Preview {
//     MainTabVeiw()
// }
class WeatherManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    
    private var manager: CLLocationManager = .init()
    @Published var mapView: MKMapView = .init()
    @Published var wetherData:Weather?
    @Published var arrWetherData:[WeatherData]?
    let city = "seoul"
    var hasLoadedWeatherData = false
    
    override init() {
        super.init()
        self.configureLocationManager()
    }
    func configureLocationManager() {
        manager.delegate = self
        
        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            mapView.showsUserLocation = true // 사용자의 현재 위치를 확인할 수 있도록
            manager.startUpdatingLocation()
            
            // configureLocationManager() 메서드 내부의 해당 부분을 수정합니다.
            if let location = manager.location {
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
                if !hasLoadedWeatherData {
                    loadWeatherData()
                }
            } else {
                // 사용자의 위치가 아직 가져오지 못했다면, 대한민국 남산으로 지도의 위치를 표시
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let defaultLocation = CLLocationCoordinate2D(latitude: 37.5514, longitude: 126.9880) // 기본 위치
                let region = MKCoordinateRegion(center: defaultLocation, span: span)
                mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func loadWeatherData() {
        let location: CLLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        let baseURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(WEATHER_API_KEY)"
        
        let alamo = AF.request(baseURL)
        
        alamo.responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let result):
                // self.arrWetherData = result.weather
                print("날씨 정보: \(result.weather)")
                self.hasLoadedWeatherData = true
            case .failure(let error):
                print("오류 발생: \(error)")
            }
        }
    }
    
    
    // MARK: - MapView에서 화면 이동이 종료되면 호출되는 메서드
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated: Bool) {
        //주소록 불러오기
        if !hasLoadedWeatherData {
            loadWeatherData()
        }
    }
}
