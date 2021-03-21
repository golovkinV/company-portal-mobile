import UIKit
import DITranquillity
import RxSwift

// MARK: - DI Registration

final class AuthPart: DIPart {
    static func load(container: DIContainer) {
        container.register(AuthPresenter.init)
            .as(AuthEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class AuthPresenter {
    private weak var view: AuthViewBehavior!
    private var router: AuthRoutable!
    private let authService: AuthService
    private let bag = DisposeBag()
    private var loaderActivity: ActivityDisposable?

    init(authService: AuthService) {
        self.authService = authService
    }
}

extension AuthPresenter: AuthEventHandler {
	func bind(view: AuthViewBehavior, router: AuthRoutable) {
        self.view = view
        self.router = router
    }
    
    func singIn(login: String, password: String) {
        loaderActivity = view.showLoading(fullscreen: false) 
        authService
            .signIn(login: login, password: password)
            .subscribe(onSuccess: { [weak self] in
                self?.stopLoading()
            }, onError: { [weak self] error in
                self?.stopLoading()
                self?.router.show(error: error)
            })
            .disposed(by: bag)
    }
    
    // MARK: - Private
    
    private func stopLoading() {
        loaderActivity?.dispose()
    }
}
