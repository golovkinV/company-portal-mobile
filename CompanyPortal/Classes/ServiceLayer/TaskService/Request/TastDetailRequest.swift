import Moya

public struct TastDetailRequest: MoyaTargetType {
    typealias Response = TaskModel

    public var path: String = ""
    public var method: Moya.Method = .get
    public var parameters: [String: Any] = [:]

    init(taskId: String) {
   		path = "/task/\(taskId)"
    }
}
