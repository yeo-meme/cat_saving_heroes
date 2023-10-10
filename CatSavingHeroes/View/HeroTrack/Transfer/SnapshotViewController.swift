//
//  SnapshotViewController.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class SnapshotViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var traces = List<Trace>()
    
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.startUpdatingLocation()
        manager.delegate = self
        return manager
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLocationUsagePermission()
        // Do any additional setup after loading the view.
        print("trace : \(traces)")
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
        self.mapView.isZoomEnabled = false
        // self.mapView.delegate = self
        
        // 지도에 trace 그려내기
        var points: [CLLocationCoordinate2D] = []
        for trace in traces {
            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(trace.latitude, trace.longtitude)
            points.append(point)
            
            print("스냅샷 그리기 : \(points)")
        }
  
        // renderPolyLine(points: points)
        
        let customScale: CGFloat = 6.0 // 원하는 스케일 값
        let customSize = CGSize(width: 300.0, height: 200.0) // 원하는 크기
        
        // 스냅샷 생성
           // let options = MKMapSnapshotter.Options()
           // options.region = region
           // options.scale = customScale
           // options.size = customSize
        
        
        // 스냅샷 생성
                let options = MKMapSnapshotter.Options()
        options.region = mapView.region // 위에서 설정한 지도 영역 사용
        options.size = CGSize(width: 400, height: 660) // 스냅샷 이미지 크기 설정
        // options.scale = UIScreen.main.scale // 디스플레이 스케일 설정
        options.scale = 0.5 // 디스플레이 스케일 설정
        options.showsBuildings = true // 건물 표시 여부
        options.showsPointsOfInterest = true // 관심 지점 표시 여부
    
        
        // 스냅샷 생성
               let snapshotter = MKMapSnapshotter(options: options)
               snapshotter.start { [weak self] (snapshot, error) in
                   if let snapshotImage = snapshot?.image {
                       // 경로를 스냅샷 이미지에 그리기
                       if let pathImage = self?.drawPathOnSnapshot(snapshotImage, with: points) {
                           // 경로가 그려진 스냅샷 이미지를 사용하거나 저장합니다.
                           // 예: 이미지 뷰에 표시
                           let imageView = UIImageView(image: pathImage)
                           // imageView.frame = self?.view.bounds ?? CGRect.zero
                           // imageView.frame = CGRect(x: 0, y: 0, width: 400, height:600 )
                           imageView.frame = CGRect(x: 0, y: 0, width: pathImage.size.width, height: pathImage.size.height)
                           //self?.view.bounds.height ?? 0 - 200
                           self?.view.addSubview(imageView)
                           
                           // 예: 이미지 저장
                           if let data = pathImage.pngData() {
                               let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                               let fileURL = documentsDirectory.appendingPathComponent("snapshot_with_path.png")
                               try? data.write(to: fileURL)
                           }
                       }
                   } else {
                       print("스냅샷 생성 중 에러 발생: \(error?.localizedDescription)")
                   }
               }
           
    }
    func drawPathOnSnapshot(_ snapshotImage: UIImage, with points: [CLLocationCoordinate2D]) -> UIImage {
        // 이미지 크기 및 스케일 설정
            let size = snapshotImage.size
            let scale = snapshotImage.scale
            // let newSize = CGSize(width: size.width * 2.0, height: size.height * 2.0)
       
            // 이미지 컨텍스트 생성
            UIGraphicsBeginImageContextWithOptions(size, true, scale)
            
            // 스냅샷 이미지 그리기
            snapshotImage.draw(at: CGPoint.zero)
            
            // 새로운 CGContext 생성
            if let context = UIGraphicsGetCurrentContext() {
                // 경로를 그릴 스타일 및 속성 설정
                context.setStrokeColor(UIColor.blue.cgColor)
                context.setLineWidth(3.0)
                
                // 좌표를 스냅샷 이미지 좌표로 변환하여 경로 그리기
                // let pointsOnSnapshot = points.map { (coordinate) -> CGPoint in
                //     let point = mapView.convert(coordinate, toPointTo: nil)
                //     return point
                // }
                
                let pointsOnSnapshot = points.map { coordinate in
                         return mapView.convert(coordinate, toPointTo: nil)
                     }
                if pointsOnSnapshot.count > 1 {
                            let path = UIBezierPath()
                            path.move(to: pointsOnSnapshot[0])
                
                            for i in 1..<pointsOnSnapshot.count {
                                let controlPoint1 = CGPoint(x: (pointsOnSnapshot[i - 1].x + pointsOnSnapshot[i].x) / 2, y: (pointsOnSnapshot[i - 1].y + pointsOnSnapshot[i].y) / 2)
                                path.addQuadCurve(to: pointsOnSnapshot[i], controlPoint: controlPoint1)
                            }
                
                            path.lineWidth = 5.0
                            path.stroke()
                        }

                context.addLines(between: pointsOnSnapshot)
                context.strokePath()
            }
            
            // 이미지 얻기
            let imageWithPath = UIGraphicsGetImageFromCurrentImageContext()
            
            // 이미지 컨텍스트 종료
            UIGraphicsEndImageContext()
            
            return imageWithPath ?? snapshotImage
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SnapshotViewController: CLLocationManagerDelegate {
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
