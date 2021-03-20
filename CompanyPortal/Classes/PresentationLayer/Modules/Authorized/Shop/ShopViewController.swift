import IGListKit

// MARK: - View Controller

final class ShopViewController: BaseCollectionViewController {

    var handler: ShopEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        handler.didLoad()
    }

    override func setupViews() {
        collectionView.collectionViewLayout = ListCollectionViewLayout(stickyHeaders: false,
                                                                       scrollDirection: .vertical,
                                                                       topContentInset: 0,
                                                                       stretchToEdge: false)
        collectionView.contentInset = .init(top: 0, left: 7.5, bottom: 0, right: 7.5)
    }
    
    override func adapterCreators() -> [AdapterCreator] {
        [
            ProductCellAdapterCreator()
        ]
    }
}

extension ShopViewController: ShopViewBehavior {
    func set(items: [ListDiffable]) {
        self.items = items
        update()
    }
}