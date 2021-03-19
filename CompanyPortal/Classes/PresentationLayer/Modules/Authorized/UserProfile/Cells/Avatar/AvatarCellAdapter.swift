import IGListKit
import UIKit

final class AvatarCellAdapterCreator: BaseAdapterCreator<ProfileAvatar, AvatarCellAdapter> {}

public final class AvatarCellAdapter: ListSectionController {

    private var item: ProfileAvatar!
    private var size: CGSize = .zero

    static let template = AvatarCell.loadFromNib(frame: UIScreen.main.bounds)!

    public override func sizeForItem(at index: Int) -> CGSize {
        size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        dequeueReusableCell(cellType: AvatarCell.self, at: index).configure(item)
    }

    public override func didUpdate(to object: Any) {
        item = object as? ProfileAvatar
        let width: CGFloat = collectionContext!.containerSize.width
        let height: CGFloat = self|.template
            .configure(item)
            .layout()
        size = CGSize(width: width, height: height)
    }
}

