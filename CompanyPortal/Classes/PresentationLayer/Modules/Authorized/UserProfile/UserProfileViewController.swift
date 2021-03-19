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
        self.items = items
        update()
    }
}
