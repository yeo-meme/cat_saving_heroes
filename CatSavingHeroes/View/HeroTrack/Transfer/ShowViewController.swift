//
//  ShowViewController.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import UIKit
import CoreLocation
import RealmSwift
import MapKit


class ShowViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.startUpdatingLocation()
        manager.delegate = self
        return manager
    }()
    
    var traces = List<Trace>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLocationUsagePermission()
    }
    
    @IBAction func goSnapshot(_ sender: Any) {
        
        // guard let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SnapShotView") else { return }
        //
        // self.navigationController?.pushViewController(pushVC, animated: true)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
          if let nextViewController = mainStoryboard.instantiateViewController(withIdentifier: "snapShotView") as? SnapshotViewController {
              // 데이터를 전달할 프로퍼티 설정
              nextViewController.traces = traces
              
              print("현재 뷰 : \(traces)")
              // 뷰 컨트롤러를 푸시하여 화면 전환
              self.navigationController?.pushViewController(nextViewController, animated: true)
          }
        
    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 지도의 화면을 원하는 장소로 움직임.
        // 내가 원하는 장소는 출발지점.
        guard let firstTrace = self.traces.first
        else {
            print("firstTrace를 가져오는 데에 실패하였습니다.")
            return
        }
        let firstCoordinate = CLLocationCoordinate2D(latitude: firstTrace.latitude, longitude: firstTrace.longtitude)
        let region = MKCoordinateRegion(center: firstCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        
        // mapView기본설정.
        self.mapView.mapType = MKMapType.standard
        self.mapView.showsUserLocation = false
        self.mapView.setUserTrackingMode(.none, animated: true)
        self.mapView.isZoomEnabled = true
        self.mapView.delegate = self
        
        // 지도에 trace 그려내기
        var points: [CLLocationCoordinate2D] = []
        for trace in traces {
            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(trace.latitude, trace.longtitude)
            points.append(point)
            print("쇼유 그리기 : \(points)")
        }
        renderPolyLine(points: points)
    }
   
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func renderPolyLine(points: [CLLocationCoordinate2D]) {
        let lineDraw = MKPolyline(coordinates: points, count: points.count)
        
        for each in 0..<points.count {
            if each != 0 && each != points.count - 1 {
                continue
            }
            let annotation = MKPointAnnotation()
            annotation.coordinate = points[each]
            if each == 0 {
                annotation.title = "start"
            } else { // each == points.count - 1
                annotation.title = "end"
            }
            self.mapView.addAnnotation(annotation as MKAnnotation)
        }
        self.mapView.addOverlay(lineDraw)

        
    }

}

extension ShowViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse :
            print("GPS 허가 설정됨")
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            self.getLocationUsagePermission()
        case .denied:
            print("GPS 권한 거부됨")
            self.getLocationUsagePermission()
        default:
            print("GPS Default")
        }
    }
}


extension ShowViewController: MKMapViewDelegate {
    // MARK:- showRouteOnMap

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        guard let polyLine = overlay as? MKPolyline
        else {
            print("can't draw polyline")
            return MKOverlayRenderer()
        }
        let renderer = MKPolylineRenderer(polyline: polyLine)
            renderer.strokeColor = .orange
            renderer.lineWidth = 5.0
            renderer.alpha = 1.0
 
        return renderer
    }
    
}
