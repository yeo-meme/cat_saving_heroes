//
//  StrayCatsItemViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/26.
//

import Foundation


class StrayCatsItemViewModel: ObservableObject {
    @Published var strayArrCats:Cats
    
    init(_ strayArrCats: Cats) {
        self.strayArrCats = strayArrCats
        print("item cell strayArrCats : \(self.strayArrCats)")
    }
    
}
