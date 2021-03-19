import IGListKit
import UIKit

class BaseCollectionViewCell: UICollectionViewCell, ListAdapterDataSource, UIScrollViewDelegate {
    public var items: [ListDiffable] = []

    private weak var refreshActivity: ActivityDisposable?
    
    // MARK: - Properties
    
    public private(set) var refreshControl: RefreshIndicator?
    
    public lazy var adapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    }()

    public var scrollViewDelegate: UIScrollViewDelegate? {
        get {
            return self.adapter.scrollViewDelegate
        }
        set {
            self.adapter.scrollViewDelegate = newValue
        }
    }

    private lazy var manager: AdapterManager = { [unowned self] in
        AdapterManager(items: self.adapterCreators())
    }()

    public func update(animated: Bool = true,
                       completion: ListUpdaterCompletion? = nil) {
        self.adapter.performUpdates(animated: animated, completion: completion)
    }

    public func reload(completion: ListUpdaterCompletion? = nil) {
        self.adapter.reloadData(completion: completion)
    }

    // MARK: - Refresh

    public func addRefreshControl(color: UIColor = MainTheme.shared.black) {
        if self.refreshControl != nil {
            return
        }
        self.adapter.collectionView?.alwaysBounceVertical = true
        self.refreshControl = RefreshIndicator(style: .prominent)
        self.refreshControl?.indicator.lineColor = color
        self.adapter.collectionView?.addSubview(self.refreshControl!)
        self.refreshControl?.addTarget(self,
                                       action: #selector(self.refresh),
                                       for: .valueChanged)
    }

    public func removeRefreshControl() {
        self.refreshControl?.removeFromSuperview()
        self.refreshControl = nil
    }

    public func stopRefreshing() {
        self.refreshControl?.endRefreshing()
        self.adapter.collectionView?.isUserInteractionEnabled = true
    }

    public func startRefreshing() {
        self.refreshControl?.startRefreshing()
    }

    public func isRefreshing() -> Bool {
        return self.refreshControl?.isRefreshing ?? false
    }

    @objc
    public func refresh() {
        self.adapter.collectionView?.isUserInteractionEnabled = false
        // override me
    }
        
    // MARK: - IGListAdapterDataSource

    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.items
    }

    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return self.manager.adapter(from: object)
    }

    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

    public func adapterCreators() -> [AdapterCreator] {
        return []
    }
}

//extension BaseCollectionViewCell: RefreshBehavior {
//    func showRefreshIndicator() -> ActivityDisposable? {
//        if self.refreshActivity?.isDisposed == false {
//            return self.refreshActivity
//        }
//        if self.isRefreshing() == false {
//            self.refreshControl?.startRefreshing()
//        }
//        return self.createActivity()
//    }
//
//    private func createActivity() -> ActivityDisposable? {
//        let activity = ActivityHolder { [weak self] in
//            self?.refreshControl?.endRefreshing()
//        }
//
//        refreshActivity = activity
//        return activity
//    }
//}

class BaseCollectionCell: UICollectionViewCell, ListAdapterDataSource {
    // MARK: - Outlets

    @IBOutlet var collectionView: UICollectionView!
    var items: [ListDiffable] = []

    // MARK: - Properties

    public lazy var adapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: nil)
    }()

    public var scrollViewDelegate: UIScrollViewDelegate? {
        get {
            return self.adapter.scrollViewDelegate
        }
        set {
            self.adapter.scrollViewDelegate = newValue
        }
    }

    private lazy var manager: AdapterManager = { [unowned self] in
        AdapterManager(items: self.adapterCreators())
    }()

    // MARK: - Setup

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }

    func setup() {
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
    }

    // MARK: - Methods

    public func adapterCreators() -> [AdapterCreator] {
        fatalError("Override me")
    }

    public func update(animated: Bool = true,
                       completion: ListUpdaterCompletion? = nil) {
        self.adapter.performUpdates(animated: animated, completion: completion)
    }

    public func reload(completion: ListUpdaterCompletion? = nil) {
        self.adapter.reloadData(completion: completion)
    }

    // MARK: - IGListAdapterDataSource

    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.items
    }

    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return self.manager.adapter(from: object)
    }

    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

class BaseInfinityCollectionCell: BaseCollectionCell {
    override func setup() {
        super.setup()
        self.scrollViewDelegate = self
    }

    public func loadMore() {
        // override me
    }
}

// MARK: - UIScrollViewDelegate

extension BaseInfinityCollectionCell: UIScrollViewDelegate {
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.width - (targetContentOffset.pointee.x + scrollView.bounds.width)
        if distance < 200 {
            self.loadMore()
        }
    }
}
