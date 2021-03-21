//
//  DateConverter.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 21.03.2021.
//

import SwiftDate

public final class DateConverter: Converter {
    public typealias FromValue = String?
    public typealias ToValue = Date?

    public func convert(from item: String?) -> Date? {
        guard let date = item else { return nil }
        return date.toDate(style: .custom("yyyy-MM-dd"))?.date
    }
}
