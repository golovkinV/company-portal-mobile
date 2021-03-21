//
//  TaskModel.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 20.03.2021.
//

import Foundation

final class TaskModel: NSObject, Decodable {
    var title: String = .init()
    var desc: String?
    var status: TastStatus = .none
    var money: Int = .init()
    var startDate: Date?
    var endDate: Date?
    
    required init(from decoder: Decoder) throws {
        super.init()
        try decoder.apply {
            title <- $0["name"]
            desc <- $0["desc"]
            status <- $0["status.key"]
            money <- $0["money"]
            startDate <- $0["startDate"] <- DateConverter()
            endDate <- $0["endDate"] <- DateConverter()
        }
    }
    
    init(title: String, desc: String?, status: TastStatus) {
        self.title = title
        self.desc = desc
        self.status = status
    }
}
