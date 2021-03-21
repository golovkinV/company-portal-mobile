//
//  User.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 21.03.2021.
//

import Foundation

final class User: NSObject, Decodable {
    var id: String = .init()
    var firstName: String = .init()
    var lastName: String = .init()
    var avatar: String = .init()
    var job: Job?
    var shopStatus: ShopStatus?
    var rewards: [Reward] = []
    var money: Int = .init()
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    init(id: String, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            id <- $0["id"]
            firstName <- $0["firstName"]
            lastName <- $0["lastName"]
            job <- $0["job"]
            shopStatus <- $0["shopStatus"]
            rewards <- $0["rewards"]
            money <- $0["money"]
        }
    }
}
