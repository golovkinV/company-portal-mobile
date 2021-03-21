import UIKit

// MARK: - Router

protocol ShopRoutable: BaseRoutable, ProductDetailRoute {}

final class ShopRouter: BaseRouter, ShopRoutable {}
