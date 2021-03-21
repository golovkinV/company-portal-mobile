//
//  ProductModel.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 20.03.2021.
//

import UIKit

enum ProductState: String, Decodable {
    case none, new, hit
    
    func fetchNaming() -> String? {
        switch self {
        case .new:
            return "NEW"
        case .hit:
            return "HIT"
        default:
            return nil
        }
    }
    
    func fetchColor() -> UIColor? {
        switch self {
        case .new:
            return #colorLiteral(red: 0.004938864615, green: 0.668953836, blue: 0.003156029619, alpha: 1)
        case .hit:
            return #colorLiteral(red: 0.9469519258, green: 0.7615528703, blue: 0.003380848328, alpha: 1)
        default:
            return nil
        }
    }
}

final class ProductModel: NSObject, Decodable {
    
    var id: String = .init()
    var name: String = .init()
    var desc: String = .init()
    var image: String?
    var state: ProductState = .none
    var price: Int = .init()
    
    required init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            id <- $0["id"]
            name <- $0["name"]
            desc <- $0["desc"]
            price <- $0["cost"]
            image <- $0["image"]
            state <- $0["state.key"]
        }
    }
}
