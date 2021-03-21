import Moya

public struct ProductDetailRequest: MoyaTargetType {
    typealias Response = ProductModel

    public var path: String = ""
    public var method: Moya.Method = .get
    public var parameters: [String: Any] = [:]

    public var task: Task {
        return .requestParameters(parameters: self.parameters, encoding: JSONEncoding.default)
    }

    init(since id: Int) {
   		parameters["id"] = id
    }
}
