import Moya

public struct UserTasksRequest: MoyaTargetType {
    typealias Response = [TaskModel]

    public var path: String = ""
    public var method: Moya.Method = .get
    public var parameters: [String: Any] = [:]

    init(userId: String) {
   		path = "/task/user/\(userId)"
    }
}
