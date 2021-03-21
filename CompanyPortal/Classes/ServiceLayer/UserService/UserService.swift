import DITranquillity
import RxCocoa
import RxSwift

class UserServicePart: DIPart {
    static func load(container: DIContainer) {
        container.register(UserServiceImp.init)
            .as(UserService.self)
            .as(UserBehavior.self)
            .lifetime(.single)
    }
}

protocol UserBehavior {
    func set(user: User)
    func fetchUserSequence() -> Observable<User?>
    func fetchUser() -> User?
    func clear()
}

protocol UserService: UserBehavior {}

final class UserServiceImp: UserService {
    
    private let schedulers: SchedulerProvider
    private let userRepository: UserRepository
    private let userRelay: BehaviorRelay<User?>
    
    init(schedulers: SchedulerProvider,
         userRepository: UserRepository) {
        self.schedulers = schedulers
        self.userRepository = userRepository
        self.userRelay = BehaviorRelay(value: userRepository.fetchUser())
    }
    
    
    // MARK: - User Behavior
    
    func set(user: User) {
        userRepository.set(user: user)
    }
    
    func fetchUserSequence() -> Observable<User?> {
        userRelay
            .asObservable()
            .observeOn(schedulers.main)
    }
    
    func fetchUser() -> User? {
        userRepository.fetchUser()
    }
    
    func clear() {
        userRepository.clear()
    }
}
