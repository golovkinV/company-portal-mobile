import IGListKit
import UIKit

final class InfoCellAdapterCreator: BaseAdapterCreator<TaskInfo, InfoCellAdapter> {}

public final class InfoCellAdapter: ListSectionController {
    
    private var item: TaskInfo!
    private var size: CGSize = .zero

    private static let template = InfoCell.loadFromNib(frame: UIScreen.main.bounds)!

    public override func sizeForItem(at index: Int) -> CGSize {
        return size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        dequeueReusableCell(cellType: InfoCell.self, at: index).configure(item)
    }

    public override func didUpdate(to object: Any) {
        self.item = object as? TaskInfo
        let width: CGFloat = collectionContext!.containerSize.width
        let height: CGFloat = self|.template
            .configure(item)
            .layout()
        
        size = CGSize(width: width, height: height)
    }
}

