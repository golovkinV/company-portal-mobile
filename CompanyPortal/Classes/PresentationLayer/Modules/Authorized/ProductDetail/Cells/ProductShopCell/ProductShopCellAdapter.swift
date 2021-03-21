import IGListKit
import UIKit

final class ProductShopCellAdapterCreator: BaseInteractiveAdapterCreator<ProductShopModel, ProductShopCellAdapter> {}

struct ProductShopCellAdapterHandler {
    let select: Action<ProductShopModel>?
}

public final class ProductShopCellAdapter: ListSectionController, Interactable {
    typealias Handler = ProductShopCellAdapterHandler
    var handler: Handler?

    private var item: ProductShopModel!
    private var size: CGSize = .zero

    private static let template = ProductShopCell.loadFromNib(frame: UIScreen.main.bounds)!

    public override func sizeForItem(at index: Int) -> CGSize {
        return size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell = dequeueReusableCell(cellType: ProductShopCell.self, at: index).configure(item)
        cell.onTapBuy = { [weak self] item in
            self?.handler?.select?(item)
        }
        return cell
    }

    public override func didUpdate(to object: Any) {
        self.item = object as? ProductShopModel
        let width: CGFloat = collectionContext!.containerSize.width
        let height: CGFloat = self|.template
            .configure(item)
            .layout()
        
        size = CGSize(width: width, height: height)
    }
}

