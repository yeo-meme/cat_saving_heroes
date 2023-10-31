//
//  Wether.swift
//  WetherParsing
//
//  Created by yeomim kim on 2023/09/12.
//

import Foundation



struct Weather:Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind:Decodable {
    let speed: Float
    let deg: Int
}

struct Clouds:Decodable {
    let all: Int
}
// 
// struct Temp:Decodable {
//     let day: Double
//   
// }

struct WeatherData:Decodable {
    let name: String
    let weather: [Weather]
    let clouds: Clouds
    let wind:Wind
    // let temp:[Temp]
}



