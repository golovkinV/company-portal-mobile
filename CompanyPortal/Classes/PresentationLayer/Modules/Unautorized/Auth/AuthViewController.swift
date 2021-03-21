import UIKit

// MARK: - View Controller

final class AuthViewController: BaseViewController {

    var handler: AuthEventHandler!
    
    @IBOutlet weak var signInButton: StateButton!
    @IBOutlet weak var loginTextField: BorderTextField!
    @IBOutlet weak var passwordTextField: BorderTextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
    }
    
    @IBAction func onTapSingInBtn(_ sender: Any) {
        handler.singIn(login: loginTextField.text ?? .init(),
                       password: passwordTextField.text ?? .init())
    }
    
    override func setupStrings() {
        let text = L10n.Auth.self
        titleLabel.text = text.title
        signInButton.setTitle(text.signIn, for: .normal)
        loginTextField.placeholder = text.login
        passwordTextField.placeholder = text.password
    }
    
    override func setupViews() {
        super.setupViews()
        
        passwordTextField.apply {
            $0.textContentType = .password
            $0.isSecureTextEntry = true
        }
        
        fetchTextViews().forEach { textView in
            textView.apply {
                $0.font = UIFont.systemFont(ofSize: 17)
                $0.borderThick = 1
                $0.defaultBorderColor = MainTheme.shared.black.withAlphaComponent(0.2)
                $0.activeBorderColor = MainTheme.shared.black.withAlphaComponent(0.2)
            }
         }
        
        signInButton.apply {
            $0.backgroundColor = MainTheme.shared.selectedColor
            $0.setTitleColor(MainTheme.shared.white, for: .normal)
            $0.isActive = false
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
        }
           
        #if DEBUG
            loginTextField.text = "tester"
            passwordTextField.text = "tester"
            signInButton.isActive = true
        #endif
    }
        
    // MARK: - Private
    
    private func setupObservables() {
        fetchTextViews().forEach {
            $0.rx.controlEvent([.editingChanged])
                .asObservable()
                .subscribe(onNext: { [weak self] in
                    self?.onTextChanged()
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func fetchTextViews() -> [BorderTextField] {
        [loginTextField,
         passwordTextField]
    }

    private func onTextChanged() {
        signInButton.isActive = areTextViewsValid()
    }
    
    private func areTextViewsValid() -> Bool {
        fetchTextViews().filter { ($0.text?.isEmpty ?? true) }.count == 0
    }
}

extension AuthViewController: AuthViewBehavior {}

