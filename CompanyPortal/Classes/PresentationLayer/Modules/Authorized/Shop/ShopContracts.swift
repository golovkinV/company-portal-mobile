import IGListKit

// MARK: - Contracts

protocol ShopViewBehavior: WaitingBehavior, RefreshBehavior {
    func set(items: [ListDiffable])
}

protocol ShopEventHandler: ViewControllerEventHandler, RefreshEventHandler {
    func bind(view: ShopViewBehavior, router: ShopRoutable)
}
