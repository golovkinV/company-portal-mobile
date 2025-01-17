import Alamofire
import DITranquillity
import Foundation

public class AppFramework: DIFramework {
    public static func load(container: DIContainer) {
        container.append(part: OtherPart.self)
        container.append(part: RepositoriesPart.self)
        container.append(part: ServicesPart.self)
        container.append(part: PresentersPart.self)
    }
}

private class RepositoriesPart: DIPart {
    static let parts: [DIPart.Type] = [
        UserRepositoryPart.self
    ]

    static func load(container: DIContainer) {
        for part in self.parts {
            container.append(part: part)
        }

        container.register {
            ClearableManagerImp(items: many($0))
        }
        .as(ClearableManager.self)
        .lifetime(.single)
    }
}

private class ServicesPart: DIPart {
    static let parts: [DIPart.Type] = [
        MoyaPluginFactoryPart.self,
        RepoServicePart.self,
        AuthServicePart.self,
        UserServicePart.self,
        ProfileSerivePart.self,
        TaskServicePart.self,
        ShopServicePart.self
    ]

    static func load(container: DIContainer) {
        for part in self.parts {
            container.append(part: part)
        }
    }
}

private class PresentersPart: DIPart {
    static let parts: [DIPart.Type] = [
        MainTabBarPart.self,
        UserProfilePart.self,
        TasksListPart.self,
        ShopPart.self,
        AuthPart.self,
        TaskDetailPart.self,
        ProductDetailPart.self
    ]

    static func load(container: DIContainer) {
        for part in self.parts {
            container.append(part: part)
        }
    }
}

private class OtherPart: DIPart {
    static func load(container: DIContainer) {
        container.register(SchedulerProviderImp.init)
            .as(SchedulerProvider.self)
            .lifetime(.single)
    }
}
