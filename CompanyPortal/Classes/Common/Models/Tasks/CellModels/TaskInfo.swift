//
//  TaskInfo.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 22.03.2021.
//

import Foundation

final class TaskInfo: NSObject { 
    let title: String
    let value: String?
    
    init(title: String, value: String?) {
        self.title = title
        self.value = value
    }
}
