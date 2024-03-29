//
//  MainTabVeiw.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import SwiftUI
import MapKit
import Alamofire
import Kingfisher

struct MainSideDrawer: View {
    @State var presentSideMenu: Bool
    @State private var showSheet = false
    @ObservedObject var weatherModel = WeatherManager()
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack{
                Image("home_weather_cat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack{
                    Text("날씨 정보: \(weatherModel.wetherData?.description ?? "")")
                }
                
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
                .offset(y: 300)
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
    @Published var arrWetherData:WeatherData?
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
                self.wetherData = result.weather.first
                print("날씨 정보: \(self.wetherData)")
                self.hasLoadedWeatherData = true
            case .failure(let error):
                print("오류 발생: \(error)")
            }
        }
    }
    
    func matchWeather(des:String) -> String {
        switch des {
        case CLEAR_SKY:
        return "sunny"
        case FEW_CLOUDS:
        return "sunny_cloudlittle2"
        case BROKEN_CLOUDS:
        return "sunny_cloudmany"
        case SCATTERED_CLOUDS:
        return "sunny_cloudmany"
        case SHOWER_RAIN:
        return "rain_many"
        case RAIN:
        return "rain_many"
        case THUNDERSTORM:
        return "thunder"
        case SNOW:
        return "snow"
            //주는 데이터 중 안개없음
        default:
            return "sunny"
        }
        
    }
    
    func wheatherMent(des:String) -> String {
        switch des {
        case CLEAR_SKY:
        return "고양이들은 햇빛 좋은 날을 좋아해요"
        case FEW_CLOUDS:
        return "하늘에 구름이 약간 있어요.\n고양이들이 햇빛을 즐길 수 있어요"
        case BROKEN_CLOUDS:
        return "하늘에 구름이 많아졌어요.\n고양이가 햇빛을 보기 어려워요"
        case SCATTERED_CLOUDS:
        return "하늘에 구름이 흩어져 있어요."
        case SHOWER_RAIN:
        return "비가 오고 있어요.\n고양이들은 지금은 실내에 머물러야 해요."
        case RAIN:
        return "비가 오고 있어요.\n고양이들은 지금은 실내에 머물러야 해요."
        case THUNDERSTORM:
        return "천둥 번개가 치고 있어요.\n고양이들을 안전한 장소로 옮겨주세요"
        case SNOW:
        return "눈이 내리고 있어요.\n고양이들이 눈에 놀랄 거예요!"
            //주는 데이터 중 안개없음
        default:
            return "고양이들은 햇빛 좋은 날을 좋아해요"
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
