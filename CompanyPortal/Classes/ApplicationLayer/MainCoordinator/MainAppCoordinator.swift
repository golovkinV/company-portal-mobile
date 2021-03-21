import DITranquillity
import RxSwift

open class MainAppCoordinator: Loggable {
    public var defaultLoggingTag: LogTag {
        return .unnamed
    }

    public static var shared: MainAppCoordinator!

    open var configuration: DependenciesConfiguration
    open var container: DIContainer
    
    private let bag: DisposeBag = DisposeBag()
    private let router: AppRouter
    private let authService: AuthService
    
    init(configuration: DependenciesConfiguration) {
        self.configuration = configuration
        self.configuration.setup()
        self.container = self.configuration.configuredContainer()
        self.router = AppRouter()
        authService = *container
        self.log(.debug, "Dependencies are configured")
    }

    func start() {
        MainTheme.shared.apply()
        self.log(.debug, "App coordinator started")
        self.openMainModule()
    }

    // MARK: - Modules routing

    private func openMainModule() {
        authService.fetchSessionStatusSequence()
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .unauthorized:
                    self.router.openAuthScene()
                case .authorized:
                    self.router.openDefaultScene()
                }
            })
            .disposed(by: bag)
    }
}
