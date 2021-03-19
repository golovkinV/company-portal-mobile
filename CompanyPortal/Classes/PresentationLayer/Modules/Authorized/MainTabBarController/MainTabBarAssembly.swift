import UIKit

// MARK: - Assembly

final class MainTabBarAssembly {
    class func createModule(selectedScreenId: Int = 1,
                            notificationId: Int? = nil,
                            parent: Router? = nil) -> MainTabBarViewController {
        let module = MainTabBarViewController() 
        let router = MainTabBarRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        let controllers: [UIViewController] = []
        module.configure(controllers: controllers)
        module.selectModule(index: selectedScreenId)
        return module
    }
}

// MARK: - Route

protocol MainTabBarRoute {}

extension MainTabBarRoute where Self: RouterProtocol {}
