import UIKit
import DITranquillity
import RxSwift

// MARK: - DI Registration

final class MainTabBarPart: DIPart {
    static func load(container: DIContainer) {
        container.register(MainTabBarPresenter.init)
            .as(MainTabBarEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class MainTabBarPresenter {
    private let bag = DisposeBag()
    private weak var view: MainTabBarViewBehavior!
    private var router: MainTabBarRoutable!
}

extension MainTabBarPresenter: MainTabBarEventHandler {
            
	func bind(view: MainTabBarViewBehavior, router: MainTabBarRoutable) {
        self.view = view
        self.router = router
    }
}
