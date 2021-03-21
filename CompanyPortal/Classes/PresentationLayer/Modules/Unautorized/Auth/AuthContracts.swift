import UIKit

// MARK: - Contracts

protocol AuthViewBehavior: WaitingBehavior {

}

protocol AuthEventHandler: ViewControllerEventHandler {
    func bind(view: AuthViewBehavior, router: AuthRoutable)
    func singIn(login: String, password: String)
}
