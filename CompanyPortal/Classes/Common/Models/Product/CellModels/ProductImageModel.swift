//
//  ProductImageModel.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 22.03.2021.
//

import Foundation

final class ProductImageModel: NSObject {
    let name: String
    let image: String?
    let state: ProductState
    
    init(name: String, image: String?, state: ProductState) {
        self.name = name
        self.image = image
        self.state = state
    }
}
