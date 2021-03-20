//
//  TaskModel.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 20.03.2021.
//

import UIKit

enum TastStatus {
    case none, toDo, inProgress, testing, done
    
    func fetchNaming() -> String? {
        switch self {
        case .toDo:
            return "To Do"
        case .inProgress:
            return "In progress"
        case .testing:
            return "Testing"
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
        default:
            return nil
        }
    }
}

final class TaskModel: NSObject {
    var title: String = .init()
    var desc: String?
    var status: TastStatus = .none
    
    required init(title: String, desc: String?, status: TastStatus) {
        self.title = title
        self.desc = desc
        self.status = status
    }
}
