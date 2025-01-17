import DITranquillity
import RxCocoa
import RxSwift

final class TaskServicePart: DIPart {
    static func load(container: DIContainer) {
        container.register(TaskServiceImp.init)
            .as(TaskService.self)
            .injection(cycle: true, { $0.moyaProvider = $1 })
            .lifetime(.single)
    }
}

protocol TaskService {
    func fetchTasks(for userId: String) -> Single<[TaskModel]>
    func fetchTaskDetail(for taskId: String) -> Single<TaskModel>
}

final class TaskServiceImp: TaskService {
    private let schedulers: SchedulerProvider
	var moyaProvider: MultiMoyaProvider!

    init(schedulers: SchedulerProvider) {
        self.schedulers = schedulers
    }
    
    func fetchTasks(for userId: String) -> Single<[TaskModel]> {
        Single.deferred { [unowned self] in
            let request = UserTasksRequest(userId: userId)
            return self.moyaProvider.request(request)
        }
        .subscribeOn(schedulers.background)
        .observeOn(schedulers.main)
    }
    
    func fetchTaskDetail(for taskId: String) -> Single<TaskModel> {
        Single.deferred { [unowned self] in
            let request = TastDetailRequest(taskId: taskId)
            return self.moyaProvider.request(request)
        }
        .subscribeOn(schedulers.background)
        .observeOn(schedulers.main)
    }
}
