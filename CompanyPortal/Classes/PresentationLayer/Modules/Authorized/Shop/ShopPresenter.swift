import UIKit
import DITranquillity

final class ShopPart: DIPart {
    static func load(container: DIContainer) {
        container.register(ShopPresenter.init)
            .as(ShopEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class ShopPresenter {
    private weak var view: ShopViewBehavior!
    private var router: ShopRoutable!
}

extension ShopPresenter: ShopEventHandler {
    
    func didLoad() {
        setDefaultItems()
    }
    
	func bind(view: ShopViewBehavior, router: ShopRoutable) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Private
    
    private func setDefaultItems() {
        let products: [ProductModel] = [
            .init(productImage: nil, statusLabel: "new", name: "Плюшевый пони", price: "25"),
            .init(productImage: nil, statusLabel: "new", name: "Мерч", price: "25 500"),
            .init(productImage: nil, statusLabel: "new", name: "Ручка", price: "155"),
            .init(productImage: nil, statusLabel: "new", name: "Разработчик +", price: "85 000")
        ]
        
        view.set(items: products)
    }
}
