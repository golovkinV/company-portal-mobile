import IGListKit
import UIKit

final class ProductCellAdapterCreator: BaseInteractiveAdapterCreator<ProductModel, ProductCellAdapter> {}

struct ProductCellAdapterHandler {
    let select: Action<ProductModel>?
}

class Model: NSObject {}

public final class ProductCellAdapter: ListSectionController, Interactable {
    typealias Handler = ProductCellAdapterHandler
    var handler: Handler?

    private var item: ProductModel!
    private var size: CGSize = .zero

    private static let template = ProductCell.loadFromNib(frame: UIScreen.main.bounds)!

    public override func sizeForItem(at index: Int) -> CGSize {
        return size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        dequeueReusableCell(cellType: ProductCell.self, at: index).configure(item)
    }

    public override func didUpdate(to object: Any) {
        self.item = object as? ProductModel
        let width: CGFloat = collectionContext!.containerSize.width/2 - (15 + 7.5)
        let height: CGFloat = 316
        size = CGSize(width: width, height: height)
        inset = .init(top: 15, left: 7.5, bottom: 0, right: 7.5)
    }

    public override func didSelectItem(at index: Int) {
        handler?.select?(item)
    }
}

