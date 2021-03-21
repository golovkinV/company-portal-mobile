import DITranquillity
import RxCocoa
import RxSwift

final class ShopServicePart: DIPart {
    static func load(container: DIContainer) {
        container.register(ShopServiceImp.init)
            .as(ShopService.self)
            .injection(cycle: true, { $0.moyaProvider = $1 })
            .lifetime(.single)
    }
}

protocol ShopService {
    func fetchProducts() -> Single<[ProductModel]>
    func fetchProductDetail(for productId: String) -> Single<ProductModel>
}

final class ShopServiceImp: ShopService {
    private let schedulers: SchedulerProvider
	var moyaProvider: MultiMoyaProvider!

    init(schedulers: SchedulerProvider) {
        self.schedulers = schedulers
    }
    
    func fetchProducts() -> Single<[ProductModel]> {
        Single.deferred { [unowned self] in
            let request = ProductsRequest()
            return self.moyaProvider.request(request)
        }
        .subscribeOn(schedulers.background)
        .observeOn(schedulers.main)
    }
    
    func fetchProductDetail(for productId: String) -> Single<ProductModel> {
        Single.deferred { [unowned self] in
            let request = ProductDetailRequest(productId: productId)
            return self.moyaProvider.request(request)
        }
        .subscribeOn(schedulers.background)
        .observeOn(schedulers.main)
    }
}
