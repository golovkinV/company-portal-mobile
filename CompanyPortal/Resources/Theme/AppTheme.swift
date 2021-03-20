import UIKit

public protocol AppTheme {
    func apply()

    // MARK: - Colors

    var white: UIColor { get }
    var black: UIColor { get }
    var baseColor: UIColor { get }
    var selectedColor: UIColor { get }
    var unselectedColor: UIColor { get }
    var red: UIColor { get }
    
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
        navbar.setBackgroundImage(.init(), for: .default)
        navbar.shadowImage = .init()
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.titleTextAttributes = [
            .foregroundColor: white,
            .font: UIFont.font(ofSize: 17, weight: .medium)
        ]
        navbar.barTintColor = baseColor
        navbar.tintColor = selectedColor
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
    public var red: UIColor = #colorLiteral(red: 0.9991626143, green: 0.1742511094, blue: 0.3347000182, alpha: 1)
    
    // MARK: - Font

    public var defaultFont: AppFont? = nil
}
