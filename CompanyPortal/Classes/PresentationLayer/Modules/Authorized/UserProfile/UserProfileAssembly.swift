import UIKit

final class UserProfileAssembly {
    class func createModule(parent: Router? = nil) -> UserProfileViewController {
        let module = UserProfileViewController() 
        let router = UserProfileRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        return module
    }
}

// MARK: - Route

protocol UserProfileRoute {}

extension UserProfileRoute where Self: RouterProtocol {}
