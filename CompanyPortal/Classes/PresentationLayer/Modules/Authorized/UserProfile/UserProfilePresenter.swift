import UIKit
import DITranquillity
import RxSwift

final class UserProfilePart: DIPart {
    static func load(container: DIContainer) {
        container.register(UserProfilePresenter.init)
            .as(UserProfileEventHandler.self)
            .lifetime(.objectGraph)
    }
}

// MARK: - Presenter

final class UserProfilePresenter {
    private let bag = DisposeBag()
    private weak var view: UserProfileViewBehavior!
    private var router: UserProfileRoutable!
    private let profileService: ProfileService
    private let userService: UserService
    
    private var loaderActivity: ActivityDisposable?
    private var user: User!
    
    init(profileService: ProfileService,
         userService: UserService) {
        self.profileService = profileService
        self.userService = userService
    }
}

extension UserProfilePresenter: UserProfileEventHandler {
    
    func didLoad() {
        fetchProfile()
    }
    
	func bind(view: UserProfileViewBehavior, router: UserProfileRoutable) {
        self.view = view
        self.router = router
    }
    
    func moduleDidLoad() {
        user = userService.fetchUser()
    }
    
    // MARK: - Private
        
    private func fetchProfile() {
        loaderActivity = view.showLoading(fullscreen: true)
        profileService
            .fetchProfile(for: user.id)
            .subscribe(onSuccess: { [weak self] profile in
                self?.stopLoading()
                self?.setItems(profile)
            }, onError: { [weak self] error in
                self?.stopLoading()
                self?.router.show(error: error)
            })
            .disposed(by: bag)
    }
    
    private func setItems(_ user: User) {
        let avatar = user.avatar.isEmpty ? #imageLiteral(resourceName: "sasuke"): UIImage(named: user.avatar)
        let profileAvatar = ProfileAvatar(fullName: user.fullName, avatarImage: avatar)
        
        var profileItems: [ProfileInfoItem] = []
        
        if let job = user.job {
            profileItems.append(.init(title: "Должность", value: job.name))
        }
        
        if let shopStatus = user.shopStatus {
            profileItems.append(.init(title: "Статус", value: "\(shopStatus.name) - действует скидка \(shopStatus.sale)% в корпоративном магазине"))
        }
        
        profileItems.append(
            contentsOf: [
                .init(title: "Всего наград", value: "\(user.rewards.count)"),
                .init(title: "Всего яблок", value: "10")
            ]
        )
        
        let profileInfoContainer = ProfileInfoContainer(items: profileItems + [LogoutModel()])
        view.set(items: [profileAvatar, profileInfoContainer])
    }
    
    private func stopLoading() {
        loaderActivity?.dispose()
    }
}
