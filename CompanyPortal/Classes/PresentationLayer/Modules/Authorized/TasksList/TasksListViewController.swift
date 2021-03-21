import IGListKit

// MARK: - View Controller

final class TasksListViewController: BaseCollectionViewController {

    var handler: TasksListEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        handler.didLoad()
    }
    
    override func setupViews() {
        view.alpha = 0
    }
    
    override func adapterCreators() -> [AdapterCreator] {
        [
            TaskCellAdapterCreator()
        ]
    }
}

extension TasksListViewController: TasksListViewBehavior {
    func set(items: [ListDiffable]) {
        if !items.isEmpty {
            view.alpha = 1
        }
        self.items = items
        update()
    }
}
