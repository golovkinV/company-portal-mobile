import Foundation
import Moya
import DITranquillity

final class MoyaPluginFactoryPart: DIPart {
    static func load(container: DIContainer) {
        container.register(MoyaPluginFactoryImpl.init)
            .as(MoyaPluginFactory.self)
            .lifetime(.single)
    }
}

protocol MoyaPluginFactory {
    func plugins(verbose: Bool, cURL: Bool) -> [PluginType]
}

final class MoyaPluginFactoryImpl: MoyaPluginFactory {
        
    func plugins(verbose: Bool, cURL: Bool) -> [PluginType] {
        return [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .formatRequestAscURL))]
    }
}
