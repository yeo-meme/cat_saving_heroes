//
//  SearchCatViewModel.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/12/06.
//

import Foundation
import Alamofire

class SearchCatViewModel: ObservableObject {
    @Published var cats = [Cats]()
    

    init() {
        fetchCats()
    }
    
    func fetchCats() {
        AF.request(CAT_SELECT_API_URL, method: .post).responseDecodable(of:[Cats].self) { response in
            switch response.result {
            case .success(let result):
                self.cats = result
                print("SearchCatViewModel 성공 : \(self.cats)")
            case .failure(let error):
                print("실패")
            }
        }
    }
    
    
    func filteredCats(_ query:String) -> [Cats] {
        let lowercasedQuery = query.lowercased()
        
        return cats.filter({
            $0.name.lowercased().contains(lowercasedQuery)
        })
    }
}
