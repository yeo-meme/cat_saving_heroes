//
//  Shop.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/31.
//

import Foundation
class Shop: ObservableObject {
  @Published var showingProduct: Bool = false
  @Published var selectedProduct: Product? //= nil
}
