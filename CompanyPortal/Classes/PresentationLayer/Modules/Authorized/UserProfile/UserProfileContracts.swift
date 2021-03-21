import IGListKit

// MARK: - Contracts

protocol UserProfileViewBehavior: WaitingBehavior {
    func set(items: [ListDiffable])
}

protocol UserProfileEventHandler: ViewControllerEventHandler {
    func bind(view: UserProfileViewBehavior, router: UserProfileRoutable)
    func moduleDidLoad()
}
