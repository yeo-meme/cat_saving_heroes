//
//  Status.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import Foundation

enum Status: Int, CaseIterable, Codable {
    case available
    case busy
    case urgentCallsOnly
    case batteryLow
    case school
    case work
    case meeting
    case gym
    case movies
    case sleeping
    case coding

    
    var title: String {
        switch self {
        case .available: return "가능"
        case .busy: return "바쁨"
        case .urgentCallsOnly: return "전화만 가능"
        case .batteryLow: return "배터리 낮음"
        case .school: return "학교"
        case .work: return "직장"
        case .meeting: return "미팅중"
        case .gym: return "운동중"
        case .movies: return "집중중"
        case .sleeping: return "자는중"
        case .coding: return "공부중"
        }
    }
}
