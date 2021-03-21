import IGListKit

// MARK: - View Controller

final class TaskDetailViewController: BaseCollectionViewController {

    var handler: TaskDetailEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        handler.didLoad()
    }

    override func adapterCreators() -> [AdapterCreator] {
        [
            TaskTitleCellAdapterCreator(),
            InfoCellAdapterCreator()
        ]
    }
}

extension TaskDetailViewController: TaskDetailViewBehavior {
    func set(items: [ListDiffable]) {
        self.items = items
        update()
    }
}
