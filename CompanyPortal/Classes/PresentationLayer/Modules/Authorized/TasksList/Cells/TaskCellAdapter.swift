import IGListKit

final class TaskCellAdapterCreator: BaseInteractiveAdapterCreator<TaskModel, TaskCellAdapter> {}

struct TaskCellAdapterHandler {
    var select: Action<TaskModel>?
}

public final class TaskCellAdapter: ListSectionController, Interactable {
    typealias Handler = TaskCellAdapterHandler
    
    var handler: Handler?
    private var item: TaskModel!
    private var size: CGSize = .zero

    static let template = TaskCell.loadFromNib(frame: UIScreen.main.bounds)!
    
    public override init() {
        super.init()
        inset = .init(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    public override func sizeForItem(at index: Int) -> CGSize {
        size
    }

    public override func cellForItem(at index: Int) -> UICollectionViewCell {
        dequeueReusableCell(cellType: TaskCell.self, at: index).configure(item)
    }

    public override func didUpdate(to object: Any) {
        item = object as? TaskModel
        let width: CGFloat = collectionContext!.containerSize.width
        let height: CGFloat = self|.template
            .configure(item)
            .layout()
        size = CGSize(width: width, height: height)
    }
    
    public override func didSelectItem(at index: Int) {
        handler?.select?(item)
    }
}

