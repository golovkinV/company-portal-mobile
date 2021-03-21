//
//  UserRepository.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 21.03.2021.
//

import DITranquillity
import Foundation
import RealmSwift

final class UserRepositoryPart: DIPart {
    static func load(container: DIContainer) {
        container.register(UserRepositoryImp.init)
            .as(UserRepository.self)
            .as(Clearable.self)
            .lifetime(.single)
    }
}

protocol UserRepository: Clearable {
    func set(user: User)
    func fetchUser() -> User?
    func clear()
}

final class UserRepositoryImp: UserRepository {
    
    func set(user: User) {
        let realm = try? Realm()
        let entity = UserEntity(user)
        let holder = CurrentUserHolder(entity)
        
        realm?.safeWrite {
            realm?.add(holder, update: .all)
        }
    }

    func fetchUser() -> User? {
        let realm = try? Realm()
        return realm?.objects(CurrentUserHolder.self)
            .first?
            .user?
            .toUser()
    }

    func clear() {
        let realm = try? Realm()
        realm?.safeWrite {
            if let items = realm?.objects(CurrentUserHolder.self) {
                realm?.delete(items)
            }
        }
    }
}

final class CurrentUserHolder: BaseRealmModel {
    @objc dynamic var user: UserEntity?
    convenience init(_ user: UserEntity) {
        self.init()
        self.user = user
        uid = UUID().uuidString 
    }
}

@objcMembers
public final class UserEntity: BaseRealmModel {
    private var firstName: String = .init()
    private var lastName: String = .init()
    
    convenience init(_ user: User) {
        self.init()
        uid = user.id
        firstName = user.firstName
        lastName = user.lastName
    }

    func toUser() -> User {
        User(id: uid, firstName: firstName, lastName: lastName)
    }
}

