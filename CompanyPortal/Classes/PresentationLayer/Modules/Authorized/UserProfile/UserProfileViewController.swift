import IGListKit

// MARK: - View Controller

final class UserProfileViewController: BaseCollectionViewController {

    var handler: UserProfileEventHandler!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        handler.didLoad()
    }
    
    override func setupViews() {
        view.backgroundColor = MainTheme.shared.baseColor
        view.alpha = 0
        collectionView.contentInset.top = 15
        addRefreshControl()
    }
    
    override func refresh() {
        handler.refresh()
    }
    
    override func adapterCreators() -> [AdapterCreator] {
        [
            AvatarCellAdapterCreator(),
            UserInfoContainerCellAdapterCreator(delegate: nil)
        ]
    }
}

extension UserProfileViewController: UserProfileViewBehavior { 
    func set(items: [ListDiffable]) {
        if !items.isEmpty {
            view.alpha = 1
        }
        self.items = items
        update()
    }
}
