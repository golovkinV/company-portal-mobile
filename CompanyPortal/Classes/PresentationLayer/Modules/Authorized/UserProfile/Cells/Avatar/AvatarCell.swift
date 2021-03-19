import UIKit
import PinLayout

final class AvatarCell: UICollectionViewCell {

    private lazy var circleView: CircleView = CircleView()
    
    private lazy var avatarImageView: UIImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var fullNameLabel: UILabel = {
        UILabel().apply {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            $0.textColor = MainTheme.shared.selectedColor
            $0.textAlignment = .center
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    // MARK: Configure

    @discardableResult
    func configure(_ item: ProfileAvatar) -> AvatarCell {
        avatarImageView.image = item.avatarImage ?? #imageLiteral(resourceName: "sasuke")
        fullNameLabel.text = item.fullName
        return self
    }

    @discardableResult
    func layout() -> CGFloat {
        
        circleView.pin.topCenter(to: contentView.anchor.topCenter).size(80)
        
        avatarImageView.pin.all()
                
        fullNameLabel.pin
            .below(of: circleView)
            .marginTop(12)
            .horizontally()
            .sizeToFit(.width)
        
        return fullNameLabel.frame.maxY + 12
    }

    // MARK: - Private
    
    private func setupViews() {
        backgroundColor = MainTheme.shared.baseColor
        
        [circleView,
         fullNameLabel].forEach {
            addSubview($0)
        }
        
        circleView.addSubview(avatarImageView)
    }
}
