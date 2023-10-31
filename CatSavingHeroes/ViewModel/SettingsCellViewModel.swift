//
//  SettingsCellViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//


import SwiftUI

enum SettingsCellViewModel: Int, CaseIterable {
    case account
    case notifications
    case starredMessages
    
    var title: String {
        switch self {
        case .account: return "Account"
        case .notifications: return "Notifications"
        case .starredMessages: return "StarredMessages"
        }
    }
        
    var imageName: String {
        switch self {
        case .account: return "key.fill"
        case .notifications: return "bell.fill"
        case .starredMessages: return "star.fill"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .account: return .blue
        case .notifications: return .red
        case .starredMessages: return .yellow
        }
    }
}
