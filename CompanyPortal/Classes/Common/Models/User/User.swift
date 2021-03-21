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
        }
    }
}
