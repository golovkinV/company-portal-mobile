import Moya

public struct ProductsRequest: MoyaTargetType {
    typealias Response = [ProductModel]

    public var path: String = "/product/all"
    public var method: Moya.Method = .get
    public var parameters: [String: Any] = [:]
}
