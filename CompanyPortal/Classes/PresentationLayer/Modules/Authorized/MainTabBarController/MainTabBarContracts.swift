import UIKit

// MARK: - Contracts

protocol MainTabBarViewBehavior: class {

}

protocol MainTabBarEventHandler: ViewControllerEventHandler {
    func bind(view: MainTabBarViewBehavior, router: MainTabBarRoutable)
}
