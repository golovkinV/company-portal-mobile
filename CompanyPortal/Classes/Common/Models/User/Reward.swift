//
//  Reward.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 21.03.2021.
//

import Foundation

final class Reward: NSObject, Decodable {
    var id: String = .init()
    var name: String = .init()
    var desc: String = .init()
    var icon: String = .init()
    
    required init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            id <- $0["_id"]
            name <- $0["name"]
            desc <- $0["desc"]
            icon <- $0["icon"]
        }
    }
}
