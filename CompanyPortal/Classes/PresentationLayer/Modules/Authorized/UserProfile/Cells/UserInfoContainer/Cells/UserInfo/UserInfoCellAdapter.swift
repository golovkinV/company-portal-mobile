import IGListKit
import UIKit

final class UserInfoCellAdapterCreator: AdapterCreator {
    
    private weak var delegate: UserInfoCellDelegate?
    
    init(delegate: UserInfoCellDelegate?) {
        self.delegate = delegate
    }
    
    func canDraw(this item: Any) -> Bool {
        item is ProfileInfoItem
    }
    
    func createAdapter() -> ListSectionController {
        UserInfoCellAdapter(delegate: delegate)
    }    
}

public final class UserInfoCellAdapter: ListSectionController {

    private weak var delegate: UserInfoCellDelegate?
    
    private var item: ProfileInfoItem!
    private var size: CGSize = .zero

    static let template = UserInfoCell.loadFromNib(frame: UIScreen.main.bounds)!

    init(delegate: UserInfoCellDelegate?) {
        self.delegate = delegate
    }
    
    public override func sizeForItem(at index: Int) -> CGSize {
        size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        dequeueReusableCell(cellType: UserInfoCell.self, at: index).configure(item)
    }

    public override func didUpdate(to object: Any) {
        item = object as? ProfileInfoItem
        let width: CGFloat = collectionContext!.containerSize.width
        let height: CGFloat = self|.template
            .configure(item)
            .layout()
        size = CGSize(width: width, height: height)
    }
}

