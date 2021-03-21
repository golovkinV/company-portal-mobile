import UIKit
import PinLayout

final class TaskCell: UICollectionViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel().apply {
            $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            $0.textColor = MainTheme.shared.black
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
        addSubview(label)
        return label
    }()
    
    private lazy var statusView: UIView = {
        let view = UIView().apply {
            $0.layer.cornerRadius = 2
        }
        addSubview(view)
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let theme = MainTheme.shared.self
        let label = UILabel().apply {
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = theme.white
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "event_arrow")
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel().apply {
            $0.textColor = MainTheme.shared.black
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
        addSubview(label)
        return label
    }()
    
    private var item: TaskModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: Configure

    @discardableResult
    func configure(_ item: TaskModel) -> TaskCell {
        self.item = item
        nameLabel.text = item.title
        statusLabel.text = item.status.fetchNaming()
        statusView.backgroundColor = item.status.fetchColor()
        descriptionLabel.text = item.desc
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = item.status.fetchColor()?.cgColor
        setNeedsLayout()
        return self
    }

    @discardableResult
    func layout() -> CGFloat {
                
        pin.horizontally(15)
        
        contentView.pin.all()
        
        nameLabel.pin
            .top(10)
            .horizontally(15)
            .sizeToFit(.widthFlexible)
        
        arrowImageView.pin
            .topRight(to: contentView.anchor.topRight)
            .marginTop(12)
            .marginRight(8)
            .size(16)
        
        statusView.pin
            .below(of: nameLabel)
            .marginTop(3)
            .horizontally(15)

        statusLabel.pin
            .all(3)
            .sizeToFit(.widthFlexible)
        
        statusView.pin
            .wrapContent(padding: .init(top: 2, left: 8, bottom: 2, right: 8))
        
        descriptionLabel.pin
            .below(of: statusView)
            .marginTop(3)
            .horizontally(15)
            .sizeToFit(.width)
        
        let maxY = item.desc == nil ? statusView.frame.maxY: descriptionLabel.frame.maxY

        return maxY + 10
    }
    
    // MARK: - Private
    
    private func setupViews() {
        contentView.apply {
            $0.backgroundColor = MainTheme.shared.white
            $0.layer.cornerRadius = 8
        }
        statusView.addSubview(statusLabel)
    }
}
