import UIKit
import PinLayout

final class UserInfoCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel().apply {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            $0.textColor = MainTheme.shared.unselectedColor
        }
        addSubview(label)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel().apply {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.textColor = MainTheme.shared.black
        }
        addSubview(label)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    // MARK: Configure

    @discardableResult
    func configure(_ item: ProfileInfoItem) -> UserInfoCell {
        titleLabel.text = item.title
        valueLabel.text = item.value
        return self
    }

    @discardableResult
    func layout() -> CGFloat {
                
        titleLabel.pin
            .top(15)
            .horizontally(15)
            .sizeToFit(.width)
        
        valueLabel.pin
            .below(of: titleLabel)
            .marginTop(2)
            .horizontally(15)
            .sizeToFit(.width)
        
        return valueLabel.frame.maxY
    }
}
