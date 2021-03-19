import IGListKit
import UIKit

final class LogoutCellAdapterCreator: AdapterCreator {
    
    private weak var delegate: LogoutCellDelegate?
    
    init(delegate: LogoutCellDelegate?) {
        self.delegate = delegate
    }
    
    func canDraw(this item: Any) -> Bool {
        item is LogoutModel
    }
    
    func createAdapter() -> ListSectionController {
        LogoutCellAdapter(delegate: delegate)
    }
}

public final class LogoutCellAdapter: ListSectionController {
    private var delegate: LogoutCellDelegate?
    
    private var item: LogoutModel!
    private var size: CGSize = .zero

    private static let template = LogoutCell.loadFromNib(frame: UIScreen.main.bounds)!

    init(delegate: LogoutCellDelegate?) {
        self.delegate = delegate
    }
    
    public override func sizeForItem(at index: Int) -> CGSize {
        size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        dequeueReusableCell(cellType: LogoutCell.self, at: index).setDelegate(delegate)
    }

    public override func didUpdate(to object: Any) {
        item = object as? LogoutModel
        let width: CGFloat = collectionContext!.containerSize.width
        let height: CGFloat = 55
        size = CGSize(width: width, height: height)
    }
}

