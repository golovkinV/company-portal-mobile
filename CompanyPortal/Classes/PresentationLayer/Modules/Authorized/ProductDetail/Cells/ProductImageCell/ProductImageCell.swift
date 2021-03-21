//
//  ProductImageCell.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 22.03.2021.
//

import UIKit

final class ProductImageCell: UICollectionViewCell {

    private lazy var nameLabel: UILabel = {
        let label = UILabel().apply {
            $0.font = UIFont.systemFont(ofSize: 24, weight: .medium)
            $0.textColor = MainTheme.shared.black
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
        addSubview(label)
        return label
    }()
    
    private lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        addSubview(view)
        return view
    }()
    
    private lazy var statusView: UIView = {
        let view = UIView().apply {
            $0.layer.cornerRadius = 2
        }
        addSubview(view)
        return view
    }()
        
    private lazy var productStateLabel: UILabel = {
        let theme = MainTheme.shared.self
        let label = UILabel().apply {
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = theme.white
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        }
        statusView.addSubview(label)

        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: Configure
    
    @discardableResult
    func configure(_ item: ProductImageModel) -> ProductImageCell {
        nameLabel.text = item.name
        
        if let image = item.image, !image.isEmpty {
            productImageView.image = UIImage(named: image) ?? #imageLiteral(resourceName: "no_image")
        } else {
            productImageView.image = #imageLiteral(resourceName: "no_image")
        }
        
        if item.state == .none {
            statusView.alpha = 0
        } else {
            statusView.apply {
                $0.alpha = 1
                $0.backgroundColor = item.state.fetchColor()
            }
            productStateLabel.text = item.state.fetchNaming()
        }
        
        return self
    }
    
    @discardableResult
    func layout() -> CGFloat {
        contentView.pin.width(UIScreen.main.bounds.width)
        
        nameLabel.pin
            .top(10)
            .horizontally(15)
            .sizeToFit(.widthFlexible)
                
        statusView.pin
            .below(of: nameLabel)
            .marginTop(3)
            .horizontally(15)

        productStateLabel.pin
            .all(3)
            .sizeToFit(.widthFlexible)
        
        statusView.pin
            .wrapContent(padding: .init(top: 2, left: 8, bottom: 2, right: 8))
          
        productImageView.pin
            .topCenter(to: contentView.anchor.topCenter)
            .marginTop(nameLabel.frame.maxY)
            .height(360)
            .width(255)
        
        return productImageView.frame.maxY
    }
}
