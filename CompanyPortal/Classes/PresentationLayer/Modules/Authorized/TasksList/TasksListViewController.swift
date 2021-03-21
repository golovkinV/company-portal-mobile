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
        collectionView.contentInset.top = 15
        addRefreshControl()
    }
    
    override func refresh() {
        handler.refresh() 
    }

    override func adapterCreators() -> [AdapterCreator] {
        [
            TaskCellAdapterCreator(.init(select: { [weak self] item in
                self?.handler.openTaskDetail(item)
            }))
        ]
    }
}

extension TasksListViewController: TasksListViewBehavior {

    func set(items: [ListDiffable]) {
        self.items = items
        update()
    }
}
