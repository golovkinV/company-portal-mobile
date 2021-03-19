import UIKit

// MARK: - View Controller

final class MainTabBarViewController: UITabBarController {

    var handler: MainTabBarEventHandler!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func configure(controllers: [UIViewController]) {
                
//        let profileViewController = controllers[0]
//        let profileNavigationController = BaseNavigationController(rootViewController: profileViewController)
//        profileNavigationController.title = text.profile
//        profileNavigationController.tabBarItem.image = #imageLiteral(resourceName: "profile_bar")
        
        viewControllers = []
    }
    
    // MARK: - Private
    
    private func setupNavBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
    }

    private func setupTabBar() {
        tabBar.apply {
            $0.backgroundImage = UIImage()
            $0.backgroundColor = MainTheme.shared.white
            $0.tintColor = MainTheme.shared.selectedColor
            $0.unselectedItemTintColor = MainTheme.shared.unselectedColor
        }
    }
}

extension MainTabBarViewController: MainTabBarViewBehavior {
    func selectModule(index: Int) {
//        selectedViewController = viewControllers?[index]
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 49
        return sizeThatFits
    }
}