//
//  TaskTitle.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 21.03.2021.
//

import Foundation

final class TaskTitle: NSObject {
    let title: String
    let status: TastStatus
    
    init(title: String, status: TastStatus) {
        self.title = title
        self.status = status
    }
}
