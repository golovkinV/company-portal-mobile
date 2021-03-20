//
//  ProductModel.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 20.03.2021.
//

import UIKit

final class ProductModel: NSObject {
    var productImage: UIImage?
    var status: String?
    var name: String = .init()
    var price: String = .init()
    
    required init(productImage: UIImage?,
                  statusLabel: String?,
                  name: String,
                  price: String) {
        self.productImage = productImage
        self.status = statusLabel
        self.name = name
        self.price = price
    }
}
