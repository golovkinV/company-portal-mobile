import IGListKit
import DITranquillity
import RxSwift
import SwiftDate

final class TaskDetailPart: DIPart {
    static func load(container: DIContainer) {
        container.register(TaskDetailPresenter.init)
            .as(TaskDetailEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class TaskDetailPresenter {
    private let bag = DisposeBag()
    private weak var view: TaskDetailViewBehavior!
    private var router: TaskDetailRoutable!
    private var taskId: String!
    private let taskService: TaskService
    private var loaderActivity: ActivityDisposable?
    
    init(taskService: TaskService) {
        self.taskService = taskService
    }
}

extension TaskDetailPresenter: TaskDetailEventHandler {
    
    func didLoad() {
        loaderActivity = view.showLoading(fullscreen: true)
        fetchTaskDetail()
    }
    
	func bind(view: TaskDetailViewBehavior, router: TaskDetailRoutable) {
        self.view = view
        self.router = router
    }
    
    func moduleDidLoad(_ taskId: String) {
        self.taskId = taskId
    }
    
    // MARK: - Private
    
    private func fetchTaskDetail() {
        taskService.fetchTaskDetail(for: taskId)
            .subscribe(onSuccess: { [weak self] task in
                self?.stopLoading()
                let title = TaskTitle(title: task.title, status: task.status)
                let start = task.startDate?.toFormat("dd.MM.yyyy")
                let end = task.endDate?.toFormat("dd.MM.yyyy")
                let executors = task.executors.map { $0.fullName }.joined(separator: "\n")
                let info = [InfoModel(title: "Описание", value: task.desc),
                            InfoModel(title: "Награда", value: "\(task.money)"),
                            InfoModel(title: "Начать", value: start),
                            InfoModel(title: "Закончить", value: end),
                            InfoModel(title: "Исполнители", value: executors)]
                let items: [ListDiffable] = [title] + info.filter { $0.value != nil }
                self?.view.set(items: items)
            }, onError: { [weak self] error in
                self?.stopLoading()
                self?.router.show(error: error)
            })
            .disposed(by: bag)
    }
    
    private func stopLoading() {
        loaderActivity?.dispose()
    }
}
