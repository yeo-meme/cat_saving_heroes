//
//  TrackingViewController.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import UIKit
import MapKit
import CoreLocation
import SwiftUI

class TrackingViewController: UIViewController {
    // 
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    var previousCoordinate: CLLocationCoordinate2D?
    var trackData: TrackData = TrackData()
    @State private var isShowingUIKitView = false
    // @State private var mapView = MKMapView()
    // @IBOutlet weak var mapView: MKMapView!
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false // 필요에
        self.mapView.mapType = MKMapType.standard
        
        mapView.showsUserLocation = true
        
        self.mapView.setUserTrackingMode(.follow, animated: true)
        
        self.mapView.isZoomEnabled = true
        self.mapView.delegate = self
        self.locationManager.startUpdatingLocation()
        return map
    }()
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        manager.delegate = self
        return manager
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        getLocationUsagePermission()
        // 
        // self.mapView.mapType = MKMapType.standard
        // 
        // mapView.showsUserLocation = true
        // 
        // self.mapView.setUserTrackingMode(.follow, animated: true)
        // 
        // self.mapView.isZoomEnabled = true
        // self.mapView.delegate = self
        // 
        self.trackData.date = Date()
        setCalendar()
    }
    fileprivate func setCalendar() {
         // mapView.delegate = self

        view.addSubview(mapView)
         // let dateSelection = UICalendarSelectionSingleDate(delegate: self)
         // dateView.selectionBehavior = dateSelection
     }
    
    
    @IBAction func stopTracking(_ sender: Any) {
        self.locationManager.stopUpdatingLocation()
        RealmHelper.shared.create(trackData)
        self.navigationController?.popViewController(animated: true)
    }
    
    func getLocationUsagePermission(){
        self.locationManager.requestWhenInUseAuthorization()
    }


    func setupButton() {
        // 버튼을 생성합니다.
        let button = UIButton(type: .system)
        button.setTitle("Show Track", for: .normal)
        button.addTarget(self, action: #selector(showTrackView), for: .touchUpInside)
        
        // 버튼을 뷰에 추가합니다.
        self.view.addSubview(button)
        
        // 버튼의 레이아웃을 설정합니다.
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc func showTrackView() {
        // ShowView를 호스팅하기 위한 UIHostingController를 생성합니다.
        // let showView = UIHostingController(rootView: ShowViewController())
        print("버튼 ")
        self.isShowingUIKitView.toggle()
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}


extension TrackingViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS권한 설정됨")
            
        case .restricted, .notDetermined:
            print("GPS권한 설정되지 않음")
            DispatchQueue.main.async {
                self.getLocationUsagePermission()
            }
        case .denied:
            print("GPS 권한 요청 거부됨")
            DispatchQueue.main.async {
                self.getLocationUsagePermission()
            }
            
        default:
            print("GPSS Defualt")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        
        
        // self.lbl?.text = "위도: \(latitude)"
        // self.lbl2?.text = "경도: \(longtitude)"
        
        if let previousCoordinate = self.previousCoordinate {
            var points:[CLLocationCoordinate2D] = []
            let point1 = CLLocationCoordinate2DMake(previousCoordinate.latitude, previousCoordinate.longitude)
            
            let point2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
            
            // let point2 = CLLocationCoordinate2D(latitude: 37.5512, longitude: 126.9882)
            
            points.append(point1)
            points.append(point2)
            
            let lineDraw = MKPolyline(coordinates: points, count: points.count)
            self.mapView.addOverlay(lineDraw)
        }
        self.previousCoordinate = location.coordinate
        
        
        let newTrace = Trace(latitude: latitude, longtitude: longtitude)
        self.trackData.appendTrace(trace: newTrace)
        print("트랙데이터 : \(self.trackData)")
        }
    }


extension TrackingViewController:MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        guard let polyLine = overlay as? MKPolyline
       
        else {
            // self.lbl3.text = "can't draw polyline"
            print("can't draw polyline")
            return MKOverlayRenderer()
        }
        
        // self.lbl3.text = "drawing"
        let renderer = MKPolylineRenderer(polyline: polyLine)
            renderer.strokeColor = .orange
            renderer.lineWidth = 5.0
            renderer.alpha = 1.0

        return renderer
    }
}
