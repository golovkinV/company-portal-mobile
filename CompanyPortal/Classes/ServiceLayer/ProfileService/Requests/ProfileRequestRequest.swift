import Moya

public struct ProfileRequest: MoyaTargetType {
    typealias Response = User

    public var method: Moya.Method = .get
    public var path: String = ""

    init(userId: String) {
        path = "/user/\(userId)"
    }
}
