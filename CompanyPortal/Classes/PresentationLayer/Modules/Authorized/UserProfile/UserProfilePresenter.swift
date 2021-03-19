import UIKit
import DITranquillity

final class UserProfilePart: DIPart {
    static func load(container: DIContainer) {
        container.register(UserProfilePresenter.init)
            .as(UserProfileEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class UserProfilePresenter {
    private weak var view: UserProfileViewBehavior!
    private var router: UserProfileRoutable!
}

extension UserProfilePresenter: UserProfileEventHandler {
    
    func didLoad() {
        setDefaultItems()
    }
    
	func bind(view: UserProfileViewBehavior, router: UserProfileRoutable) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Private
    
    private func setDefaultItems() {
        let avatar = #imageLiteral(resourceName: "sasuke")
        let profileAvatar = ProfileAvatar(fullName: "Sasuke Uchiha", avatarImage: avatar)
        let profileItems: [ProfileInfoItem] = [
            .init(title: "Должность", value: "Инженер-программист"),
            .init(title: "Всего наград", value: "10"),
            .init(title: "Всего яблок", value: "10")
        ]
        let profileInfoContainer = ProfileInfoContainer(items: profileItems + [LogoutModel()])
        view.set(items: [profileAvatar, profileInfoContainer])
    }
}
