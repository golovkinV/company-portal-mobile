import UIKit
import DITranquillity
import RxSwift

final class ShopPart: DIPart {
    static func load(container: DIContainer) {
        container.register(ShopPresenter.init)
            .as(ShopEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class ShopPresenter {
    private let bag = DisposeBag()
    private weak var view: ShopViewBehavior!
    private var router: ShopRoutable!
    private let shopService: ShopService
    private var loaderActivity: ActivityDisposable?
    
    init(shopService: ShopService) {
        self.shopService = shopService
    }
}

extension ShopPresenter: ShopEventHandler {

    func didLoad() {
        loaderActivity = view.showLoading(fullscreen: true)
        fetchProducts()
    }
    
	func bind(view: ShopViewBehavior, router: ShopRoutable) {
        self.view = view
        self.router = router
    }
    
    func refresh() {
        loaderActivity = view.showRefreshIndicator()
        fetchProducts()
    }
    
    // MARK: - Private
    
    private func fetchProducts() {
        shopService.fetchProducts()
            .subscribe(onSuccess: { [weak self] products in
                self?.stopLoading()
                self?.view.set(items: products)
            }, onError: { [weak self] error in
                self?.stopLoading()
                self?.router.show(error: error)
            })
            .disposed(by: bag)
    }
    
    private func stopLoading() {
        loaderActivity?.dispose()
    }
}
