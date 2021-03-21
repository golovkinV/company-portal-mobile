import IGListKit

// MARK: - Contracts

protocol TasksListViewBehavior: WaitingBehavior {
    func set(items: [ListDiffable])
}

protocol TasksListEventHandler: ViewControllerEventHandler {
    func bind(view: TasksListViewBehavior, router: TasksListRoutable)
    func moduleDidLoad()
}
