import UIKit

final class TasksListAssembly {
    class func createModule(parent: Router? = nil) -> TasksListViewController {
        let module = TasksListViewController() 
        let router = TasksListRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        module.handler.moduleDidLoad()
        return module
    }
}

// MARK: - Route

protocol TasksListRoute {}

extension TasksListRoute where Self: RouterProtocol {}
