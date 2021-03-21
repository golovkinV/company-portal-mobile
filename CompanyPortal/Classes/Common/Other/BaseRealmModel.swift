//
//  File.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 21.03.2021.
//

import Realm
import RealmSwift

public class BaseRealmModel: Object {
    @objc public dynamic var uid: String = ""

    public override class func primaryKey() -> String? {
        return "uid"
    }
}
