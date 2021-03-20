import UIKit
import DITranquillity

final class TasksListPart: DIPart {
    static func load(container: DIContainer) {
        container.register(TasksListPresenter.init)
            .as(TasksListEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class TasksListPresenter {
    private weak var view: TasksListViewBehavior!
    private var router: TasksListRoutable!
}

extension TasksListPresenter: TasksListEventHandler {
    
    func didLoad() {
        setDefaultItems()
    }
    
	func bind(view: TasksListViewBehavior, router: TasksListRoutable) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Private
    
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
}
