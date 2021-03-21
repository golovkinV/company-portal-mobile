import UIKit

// MARK: - Router

protocol TasksListRoutable: BaseRoutable, TaskDetailRoute {}

final class TasksListRouter: BaseRouter, TasksListRoutable {}
