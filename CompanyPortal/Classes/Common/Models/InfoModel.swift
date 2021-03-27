//
//  TaskInfo.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 22.03.2021.
//

import Foundation

class InfoModel: NSObject {
    let title: String
    let value: String?
    let sale: Int?
    
    init(title: String, value: String?, sale: Int? = nil) {
        self.title = title
        self.value = value
        self.sale = sale
    }
}
