import Moya

public struct ProductDetailRequest: MoyaTargetType {
    typealias Response = ProductModel

    public var path: String = ""
    public var method: Moya.Method = .get
    public var parameters: [String: Any] = [:]

    init(productId: String) {
   		path = "/product/\(productId)"
    }
}
