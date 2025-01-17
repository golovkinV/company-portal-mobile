//
//  TaskStatus.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 21.03.2021.
//

import UIKit

enum TastStatus: String, Decodable {
    case none = "none",
         toDo = "to_do",
         inProgress = "in_progress",
         testing = "testing",
         bug = "bug",
         done = "done"
    
    func fetchNaming() -> String? {
        switch self {
        case .toDo:
            return "To Do"
        case .inProgress:
            return "In progress"
        case .testing:
            return "Testing"
        case .bug:
            return "Bug"
        case .done:
            return "Done"
        default:
            return nil
        }
    }
    
    func fetchColor() -> UIColor? {
        switch self {
        case .toDo:
            return #colorLiteral(red: 0.5985590816, green: 0.8740757108, blue: 0.4473269582, alpha: 1)
        case .inProgress:
            return #colorLiteral(red: 0.2405880392, green: 0.5081863403, blue: 0.8732247353, alpha: 1)
        case .testing:
            return #colorLiteral(red: 0.9545277953, green: 0.6120269299, blue: 0.08543778211, alpha: 1)
        case .done:
            return #colorLiteral(red: 0.1446862817, green: 0.6844187379, blue: 0.377703011, alpha: 1)
        case .bug:
            return #colorLiteral(red: 0.9074296355, green: 0.2955675721, blue: 0.2338493466, alpha: 1)
        default:
            return nil
        }
    }
    
    private var sortOrder: Int {
        switch self {
        case .toDo:
            return 0
        case .inProgress:
            return 1
        case .testing:
            return 2
        case .bug:
            return 3
        case .done:
            return 4
        case .none:
            return 5
        }
    }
    
    static func ==(lhs: TastStatus, rhs: TastStatus) -> Bool {
        return lhs.sortOrder == rhs.sortOrder
    }

    static func <(lhs: TastStatus, rhs: TastStatus) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
}
