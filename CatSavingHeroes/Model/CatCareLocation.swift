//
//  CatCareLocation.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/19.
//

import Foundation
import MapKit

struct CatCareLocation: Codable, Identifiable {
    var id: String
    var name: String
    var image: String
    var latitude: Double
    var longitude: Double
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

    let MOCK_UP = CatCareLocation(id: "0000", name: "먼지", image: "OIGG", latitude: 37.509259, longitude: 126.978964)
    
    
class CustomAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var image: String?
    @objc dynamic var coordinate: CLLocationCoordinate2D

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, image:String) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.image = image
    }
}
