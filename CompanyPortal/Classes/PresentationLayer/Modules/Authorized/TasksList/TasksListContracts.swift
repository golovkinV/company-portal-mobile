import IGListKit

// MARK: - Contracts

protocol TasksListViewBehavior: WaitingBehavior, RefreshBehavior {
    func set(items: [ListDiffable])
}

protocol TasksListEventHandler: ViewControllerEventHandler, RefreshEventHandler {
    func bind(view: TasksListViewBehavior, router: TasksListRoutable)
    func moduleDidLoad()
    func openTaskDetail(_ item: TaskModel)
}
