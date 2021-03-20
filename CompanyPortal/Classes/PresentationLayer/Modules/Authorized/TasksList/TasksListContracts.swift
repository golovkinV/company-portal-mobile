import IGListKit

// MARK: - Contracts

protocol TasksListViewBehavior: class {
    func set(items: [ListDiffable])
}

protocol TasksListEventHandler: ViewControllerEventHandler {
    func bind(view: TasksListViewBehavior, router: TasksListRoutable)
}
