import UIKit

public protocol AppTheme {
    func apply()

    // MARK: - Colors

    var white: UIColor { get }
    var black: UIColor { get }
    var baseColor: UIColor { get }
    var selectedColor: UIColor { get }
    var unselectedColor: UIColor { get }
    var defaultFont: AppFont? { get }
}

public struct MainTheme: AppTheme {
    public static var shared: AppTheme = MainTheme()

    public func apply() {
        self.configureNavBar()
        self.configureTextView()
        self.configureCollectionView()
    }

    func configureNavBar() {
        let navbar = UINavigationBar.appearance()
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.titleTextAttributes = [
            .foregroundColor: black,
            .font: UIFont.font(ofSize: 17, weight: .medium)
        ]
        navbar.barTintColor = self.white
        navbar.tintColor = black
    }

    func configureTextView() {
        UITextView.appearance().tintColor = self.black
        UITextField.appearance().tintColor = self.black
    }

    func configureCollectionView() {
        UICollectionView.appearance().isPrefetchingEnabled = false
    }

    // MARK: - Colors

    public var white: UIColor = .white
    public var black: UIColor = .black
    public var baseColor: UIColor = #colorLiteral(red: 0.930835247, green: 0.9659045339, blue: 0.9994764924, alpha: 1)
    public var selectedColor: UIColor = #colorLiteral(red: 0.07494878024, green: 0.3862712085, blue: 0.8201563358, alpha: 1)
    public var unselectedColor: UIColor = #colorLiteral(red: 0.5568057895, green: 0.5569025874, blue: 0.5567930341, alpha: 1)
    
    // MARK: - Font

    public var defaultFont: AppFont? = nil
}
