import UIKit

final class ShopAssembly {
    class func createModule(parent: Router? = nil) -> ShopViewController {
        let module = ShopViewController() 
        let router = ShopRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        return module
    }
}

// MARK: - Route

protocol ShopRoute {}

extension ShopRoute where Self: RouterProtocol {}
