import DITranquillity
import RxCocoa
import RxSwift

class ProfileSerivePart: DIPart {
    static func load(container: DIContainer) {
        container.register(ProfileServiceImp.init)
            .as(ProfileService.self)
            .injection(cycle: true, { $0.moyaProvider = $1 })
            .lifetime(.single)
    }
}

protocol ProfileService {
    func fetchProfile(for userId: String) -> Single<User>
}

final class ProfileServiceImp: ProfileService {
    private let schedulers: SchedulerProvider
    var moyaProvider: MultiMoyaProvider!

    init(schedulers: SchedulerProvider) {
        self.schedulers = schedulers
    }
    
    func fetchProfile(for userId: String) -> Single<User> {
        Single.deferred { [unowned self] in
            let request = ProfileRequest(userId: userId)
            return self.moyaProvider.request(request)
        }
        .subscribeOn(schedulers.background)
        .observeOn(schedulers.main)
    }
}
