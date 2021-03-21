import IGListKit
import UIKit

final class TitleCellAdapterCreator: BaseAdapterCreator<TaskTitle, TitleCellAdapter> {}

public final class TitleCellAdapter: ListSectionController {

    private var item: TaskTitle!
    private var size: CGSize = .zero

    private static let template = TitleCell.loadFromNib(frame: UIScreen.main.bounds)!

    public override func sizeForItem(at index: Int) -> CGSize {
        return size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        dequeueReusableCell(cellType: TitleCell.self, at: index).configure(item)
    }

    public override func didUpdate(to object: Any) {
        self.item = object as? TaskTitle
        let width: CGFloat = collectionContext!.containerSize.width
        let height: CGFloat = self|.template  
            .configure(item)
            .layout()
        
        size = CGSize(width: width, height: height)
    }
}

