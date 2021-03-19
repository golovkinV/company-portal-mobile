import IGListKit

// MARK: - Contracts

protocol UserProfileViewBehavior: class {
    func set(items: [ListDiffable])
}

protocol UserProfileEventHandler: ViewControllerEventHandler {
    func bind(view: UserProfileViewBehavior, router: UserProfileRoutable)
}
