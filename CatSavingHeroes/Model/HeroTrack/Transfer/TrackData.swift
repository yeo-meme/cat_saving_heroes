//
//  TrackData.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/10.
//

import Foundation
import RealmSwift

class TrackData:Object {
    @objc dynamic var date: Date? = nil
    let traces = List<Trace>()
    
    convenience init(date: Date?) {
        self.init()
        self.date = date
    }
    
    func appendTrace(trace: Trace) {
        self.traces.append(trace)
    }
    
    func fomattedDate() -> String {
        guard let date = self.date else {return ""}
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
    
}
