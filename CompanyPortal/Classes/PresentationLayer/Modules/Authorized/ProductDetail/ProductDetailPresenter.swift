import IGListKit
import DITranquillity
import RxSwift

final class ProductDetailPart: DIPart {
    static func load(container: DIContainer) {
        container.register(ProductDetailPresenter.init)
            .as(ProductDetailEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class ProductDetailPresenter {
    private let bag = DisposeBag()
    private weak var view: ProductDetailViewBehavior!
    private var router: ProductDetailRoutable!
    private var productId: String!
    private let shopService: ShopService
    private var loaderActivity: ActivityDisposable?
    
    init(shopService: ShopService) {
        self.shopService = shopService
    }
    
}

extension ProductDetailPresenter: ProductDetailEventHandler {
    
    func didLoad() {
        loaderActivity = view.showLoading(fullscreen: true)
        fetchProductDetail()
    }
    
	func bind(view: ProductDetailViewBehavior, router: ProductDetailRoutable) {
        self.view = view
        self.router = router
    }
    
    func moduleDidLoad(_ productId: String) {
        self.productId = productId
    }
    
    func buyProduct(_ item: ProductShopModel) {
        
    }
    
    // MARK: - Private
    
    private func fetchProductDetail() {
        shopService.fetchProductDetail(for: productId)
            .subscribe(onSuccess: { [weak self] product in
                self?.stopLoading()
                let image = ProductImageModel(name: product.name, image: product.image, state: product.state)
                let shop = ProductShopModel(price: product.price)
                let info = [InfoModel(title: "Описание", value: product.desc),
                            InfoModel(title: "Цена", value: "\(product.price)")]
                let items: [ListDiffable] = [image] + info.filter { $0.value != nil } + [shop]
                self?.view.set(items: items)
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
