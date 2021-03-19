import UIKit
import PinLayout

final class LogoutCell: UICollectionViewCell {

    private var delegate: LogoutCellDelegate?
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton().apply {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            $0.setTitleColor(MainTheme.shared.red, for: .normal)
            $0.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        }
        button.addTarget(self, action: #selector(onTapLogout), for: .touchUpInside)
        addSubview(button)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStrings()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    @discardableResult
    func setDelegate(_ delegate: LogoutCellDelegate?) -> LogoutCell {
        self.delegate = delegate
        return self
    }
    
    func layout() {
        logoutButton.pin
            .vertically()
            .horizontally(15)
    }
    
    @objc func onTapLogout(_ sender: UIButton) {
        delegate?.signOut()
    }
    
    // MARK: - Private
    
    private func setupStrings() {
        logoutButton.setTitle("Выйти из аккаунта", for: .normal)
    }
}
