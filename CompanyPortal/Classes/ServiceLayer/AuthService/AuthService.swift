import DITranquillity
import RxCocoa
import RxSwift

public enum SessionStatus: String {
    case authorized
    case unauthorized
}

final class AuthServicePart: DIPart {
    static func load(container: DIContainer) {
        container.registerMoyaProvider(verbose: true, cURL: true)
        container.register(AuthServiceImp.init)
            .as(AuthService.self)
            .injection(cycle: true, { $0.moyaProvider = $1 })
            .lifetime(.single)
    }
}

protocol AuthService {
    func signIn(login: String, password: String) -> Single<Void>
    func fetchSessionStatusSequence() -> Observable<SessionStatus>
}

final class AuthServiceImp: AuthService {
    private let schedulers: SchedulerProvider
    private let userService: UserService
    var moyaProvider: MultiMoyaProvider!
    
    private let sessionStatusRelay: BehaviorRelay<SessionStatus>
    
    init(schedulers: SchedulerProvider,
         userService: UserService) {
        self.schedulers = schedulers
        self.userService = userService
        sessionStatusRelay = BehaviorRelay(
            value: userService.fetchUser() == nil ? .unauthorized : .authorized
        )
    }
    
    func signIn(login: String, password: String) -> Single<Void> {
        Single.deferred { [unowned self] in
            let request = SignInRequest(login: login, password: password)
            return self.moyaProvider
                .request(request)
                .flatMap { [unowned self] user in
                    self.userService.set(user: user)
                    self.sessionStatusRelay.accept(.authorized)
                    return .just(())
                }
        }
        .subscribeOn(schedulers.background)
        .observeOn(schedulers.main)
    }
    
    func fetchSessionStatusSequence() -> Observable<SessionStatus> {
        sessionStatusRelay
            .asObservable()
            .distinctUntilChanged()
            .observeOn(schedulers.main)
    }
}
