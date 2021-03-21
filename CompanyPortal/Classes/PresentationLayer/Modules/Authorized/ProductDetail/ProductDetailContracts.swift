import IGListKit

// MARK: - Contracts

protocol ProductDetailViewBehavior: WaitingBehavior {
    func set(items: [ListDiffable])
}

protocol ProductDetailEventHandler: ViewControllerEventHandler {
    func bind(view: ProductDetailViewBehavior, router: ProductDetailRoutable)
    func moduleDidLoad(_ productId: String)
    func buyProduct(_ item: ProductShopModel)
}