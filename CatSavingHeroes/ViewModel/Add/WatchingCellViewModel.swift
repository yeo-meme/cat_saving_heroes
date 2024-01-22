//
//  TakeCareOfCatCellViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/11/02.
//

import Foundation
class WatchingCellViewModel: ObservableObject{
    @Published var userCat:Cats
    
    init(_ userCat: Cats) {
        self.userCat = userCat
        print("item cell WatchItemCellModel : \(self.userCat)")
    }
}
