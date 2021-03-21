//
//  Realm.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 21.03.2021.
//

import Realm
import RealmSwift

extension Realm {
    func safeWrite(_ action: () -> Void) {
        if self.isInWriteTransaction {
            action()
        } else {
            _ = try? self.write {
                action()
            }
        }
        self.refresh()
    }
}
