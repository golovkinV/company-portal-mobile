import IGListKit

// MARK: - Contracts

protocol TaskDetailViewBehavior: WaitingBehavior {
    func set(items: [ListDiffable])
}

protocol TaskDetailEventHandler: ViewControllerEventHandler {
    func bind(view: TaskDetailViewBehavior, router: TaskDetailRoutable)
    func moduleDidLoad(_ taskId: String)
}
