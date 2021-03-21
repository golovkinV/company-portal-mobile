import IGListKit
import UIKit

final class ProductImageCellAdapterCreator: BaseAdapterCreator<ProductImageModel, ProductImageCellAdapter> {}

public final class ProductImageCellAdapter: ListSectionController {

    private var item: ProductImageModel!
    private var size: CGSize = .zero

    private static let template = ProductImageCell.loadFromNib(frame: UIScreen.main.bounds)!

    public override func sizeForItem(at index: Int) -> CGSize {
        return size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        dequeueReusableCell(cellType: ProductImageCell.self, at: index).configure(item)
    }

    public override func didUpdate(to object: Any) {
        self.item = object as? ProductImageModel
        let width: CGFloat = collectionContext!.containerSize.width
        let height: CGFloat = self|.template
            .configure(item)
            .layout()
        
        size = CGSize(width: width, height: height)
    }
}

