import Moya

public struct SignInRequest: MoyaTargetType {
    typealias Response = User

    public var method: Moya.Method = .post
    public var path: String = "/user/login"
    var parameters: [String: Any] = [:]

    public var task: Task {
        return .requestParameters(parameters: self.parameters, encoding: JSONEncoding.default)
    }

    init(login: String, password: String) {
        parameters = [
            "login": login,
            "password": password
        ]
    }
}
