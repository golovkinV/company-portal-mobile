import IGListKit

// MARK: - View Controller

final class TasksListViewController: BaseCollectionViewController {

    var handler: TasksListEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        handler.didLoad()
    }
    
    override func adapterCreators() -> [AdapterCreator] {
        [
            TaskCellAdapterCreator()
        ]
    }
}

extension TasksListViewController: TasksListViewBehavior {
    func set(items: [ListDiffable]) {
        self.items = items
        update()
    }
}
