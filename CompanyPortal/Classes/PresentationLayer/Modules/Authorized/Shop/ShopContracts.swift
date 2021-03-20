import IGListKit

// MARK: - Contracts

protocol ShopViewBehavior: class {
    func set(items: [ListDiffable])
}

protocol ShopEventHandler: ViewControllerEventHandler {
    func bind(view: ShopViewBehavior, router: ShopRoutable)
}
