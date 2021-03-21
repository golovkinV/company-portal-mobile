import UIKit
import FittedSheets

final class TaskDetailAssembly {
    class func createModule(parent: Router? = nil,
                            taskId: String) -> TaskDetailViewController {
        let module = TaskDetailViewController() 
        let router = TaskDetailRouter(view: module, parent: parent)
        module.handler = MainAppCoordinator.shared.container.resolve()
        module.handler.bind(view: module, router: router)
        module.handler.moduleDidLoad(taskId)
        return module
    }
}

// MARK: - Route

protocol TaskDetailRoute {
    func openTaskDetail(for taskId: String)
}

extension TaskDetailRoute where Self: RouterProtocol {
    func openTaskDetail(for taskId: String) {
        let module = TaskDetailAssembly.createModule(taskId: taskId)
        
        let options = SheetOptions(gripColor: MainTheme.shared.selectedColor.withAlphaComponent(0.3),
                                   cornerRadius: 10,
                                   shrinkPresentingViewController: false,
                                   useInlineMode: false)
        
        let sheetController = SheetViewController(controller: module,
                                                  sizes: [.percent(0.65), .fullscreen],
                                                  options: options)

        controller.present(sheetController, animated: true, completion: nil)
    }
}
