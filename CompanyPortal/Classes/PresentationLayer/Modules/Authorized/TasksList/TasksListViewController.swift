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
    
    override func setupViews() {
//        collectionView.collectionViewLayout = ListCollectionViewLayout(stickyHeaders: false,
//                                                                       scrollDirection: .vertical,
//                                                                       topContentInset: 0,
//                                                                       stretchToEdge: false)
    }
}

extension TasksListViewController: TasksListViewBehavior {
    func set(items: [ListDiffable]) {
        self.items = items
        update()
    }
}
