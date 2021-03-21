import UIKit
import FittedSheets

final class ProductDetailAssembly {
    class func createModule(parent: Router? = nil,
                            productId: String) -> ProductDetailViewController {
        let module = ProductDetailViewController() 
        let router = ProductDetailRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        module.handler.moduleDidLoad(productId)
        return module
    }
}

// MARK: - Route

protocol ProductDetailRoute {
    func openProductDetail(for productId: String)
}

extension ProductDetailRoute where Self: RouterProtocol {
    func openProductDetail(for productId: String) {
        let module = ProductDetailAssembly.createModule(productId: productId)
        
        let options = SheetOptions(gripColor: MainTheme.shared.selectedColor.withAlphaComponent(0.3),
                                   cornerRadius: 10,
                                   shrinkPresentingViewController: false,
                                   useInlineMode: false)
        
        let sheetController = SheetViewController(controller: module,
                                                  sizes: [.percent(0.65), .fullscreen],
                                                  options: options)

        controller.present(sheetController, animated: true, completion: nil)
    }
}
