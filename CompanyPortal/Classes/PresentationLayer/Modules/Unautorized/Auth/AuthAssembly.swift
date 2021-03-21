import UIKit

// MARK: - Assembly

final class AuthAssembly {
    class func createModule(parent: Router? = nil) -> AuthViewController {
        let module = AuthViewController() 
        let router = AuthRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        return module
    }
}

// MARK: - Route

protocol AuthRoute {
    func openAuth()
}

extension AuthRoute where Self: RouterProtocol {
    func openAuth() {
        let module = AuthAssembly.createModule()
        PushRouter(target: module, parent: controller).move()
    }
}
