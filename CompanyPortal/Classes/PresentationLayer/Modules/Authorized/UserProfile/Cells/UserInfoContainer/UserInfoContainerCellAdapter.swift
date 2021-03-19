import IGListKit
import UIKit

final class UserInfoContainerCellAdapterCreator: AdapterCreator {
    
    private weak var delegate: UserInfoContainerCellDelegate?
    
    init(delegate: UserInfoContainerCellDelegate?) {
        self.delegate = delegate
    }
    
    func canDraw(this item: Any) -> Bool {
        item is ProfileInfoContainer
    }
    
    func createAdapter() -> ListSectionController {
        UserInfoContainerCellAdapter(delegate: delegate)
    }
}

public final class UserInfoContainerCellAdapter: ListSectionController {

    private var delegate: UserInfoContainerCellDelegate?
    
    private var item: ProfileInfoContainer!
    private var size: CGSize = .zero

    private static let template = UserInfoContainerCell.loadFromNib(frame: UIScreen.main.bounds)!

    init(delegate: UserInfoContainerCellDelegate?) {
        self.delegate = delegate
    }
    
    public override func sizeForItem(at index: Int) -> CGSize {
        size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        dequeueReusableCell(cellType: UserInfoContainerCell.self, at: index)
            .setDelegate(delegate)
            .configure(item)
    }

    public override func didUpdate(to object: Any) {
        item = object as? ProfileInfoContainer
        let width: CGFloat = collectionContext!.containerSize.width
        let height: CGFloat = collectionContext!.containerSize.height
        size = CGSize(width: width, height: height)
    }
}

