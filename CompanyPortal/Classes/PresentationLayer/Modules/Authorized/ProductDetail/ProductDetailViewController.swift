import IGListKit

// MARK: - View Controller

final class ProductDetailViewController: BaseCollectionViewController {

    var handler: ProductDetailEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        handler.didLoad()
    }
    
    override func setupViews() {
        sheetViewController?.handleScrollView(collectionView)
    }
    
    override func adapterCreators() -> [AdapterCreator] {
        [
            ProductImageCellAdapterCreator(),
            InfoCellAdapterCreator(),
            ProductShopCellAdapterCreator(.init(select: { [weak self] item in
                self?.handler.buyProduct(item)
            }))
        ]
    }
}

extension ProductDetailViewController: ProductDetailViewBehavior {
    func set(items: [ListDiffable]) {
        self.items = items
        update()
    }
    
    func close() {
        sheetViewController?.dismiss(animated: true, completion: nil)
    }
}
