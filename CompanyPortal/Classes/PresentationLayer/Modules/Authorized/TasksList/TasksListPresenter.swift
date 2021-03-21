import UIKit
import DITranquillity
import RxSwift

final class TasksListPart: DIPart {
    static func load(container: DIContainer) {
        container.register(TasksListPresenter.init)
            .as(TasksListEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class TasksListPresenter {
    private let bag = DisposeBag()
    private weak var view: TasksListViewBehavior!
    private var router: TasksListRoutable!
    private let taskService: TaskService
    private let userService: UserService
    private var user: User!
    private var loaderActivity: ActivityDisposable?
    
    init(taskService: TaskService,
         userService: UserService) {
        self.taskService = taskService
        self.userService = userService
    }
}

extension TasksListPresenter: TasksListEventHandler {
    
    func openTaskDetail(_ item: TaskModel) {
        router.openTaskDetail(for: item.id)
    }
    
    func didLoad() {
        loaderActivity = view.showLoading(fullscreen: true)
        fetchTasks()
    }
    
    func moduleDidLoad() {
        user = userService.fetchUser()
    }
    
    func refresh() {
        loaderActivity = view.showRefreshIndicator()
        fetchTasks()
    }
    
	func bind(view: TasksListViewBehavior, router: TasksListRoutable) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Private
    
    private func fetchTasks() {
        taskService.fetchTasks(for: user.id)
            .subscribe(onSuccess: { [weak self] tasks in
                self?.stopLoading()
                self?.view.set(items: tasks.sorted(by: { $0.status < $1.status  }))
            }, onError: { [weak self] error in
                self?.stopLoading()
                self?.router.show(error: error)
            })
            .disposed(by: bag)
    }
    
    private func setDefaultItems() {
        let tasks: [TaskModel] = [
            .init(title: "Выпить кофе",
                  desc: "Необходимо сварить самый крепкий кофе, который ты делал в своей жизни",
                  status: .toDo),
            .init(title: "Код-ревью",
                  desc: "Проверка Pull Request на GitHub",
                  status: .inProgress),
            .init(title: "Проверка релизной сборки",
                  desc: nil,
                  status: .testing),
            .init(title: "Публикация",
                  desc: "Новая сборка\nОписание релиза: Поправили мелкие баги и повысили эффективность работы кода\nВерсия: 1.0.2 (21)",
                  status: .done)
        ]
        
        view.set(items: tasks)
    }
    
    private func stopLoading() {
        loaderActivity?.dispose()
    }
}
