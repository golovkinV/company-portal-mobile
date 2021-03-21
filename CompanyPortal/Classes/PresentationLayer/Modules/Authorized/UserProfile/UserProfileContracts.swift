import IGListKit

// MARK: - Contracts

protocol UserProfileViewBehavior: WaitingBehavior, RefreshBehavior {
    func set(items: [ListDiffable])
}

protocol UserProfileEventHandler: ViewControllerEventHandler, RefreshEventHandler {
    func bind(view: UserProfileViewBehavior, router: UserProfileRoutable)
    func moduleDidLoad()
}
