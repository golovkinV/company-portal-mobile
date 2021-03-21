import UIKit

public struct Configuration {
    #if DEBUG
    static let server = "http://192.168.1.82:8080/api"
    #else
    static let server = "http://192.168.1.82:8080/api"
    #endif
}
