//
//  ProductCell.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 20.03.2021.
//

import UIKit

final class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusLabel.backgroundColor = MainTheme.shared.selectedColor
        contentView.apply {
            $0.backgroundColor = MainTheme.shared.baseColor
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = MainTheme.shared.selectedColor.cgColor
        }
        productImageView.layer.cornerRadius = 8
    }

    // MARK: Configure
    
    @discardableResult
    func configure(_ item: ProductModel) -> ProductCell {
        
        if let image = item.image, !image.isEmpty {
            productImageView.image = UIImage(named: image) ?? #imageLiteral(resourceName: "no_image")
        } else {
            productImageView.image = #imageLiteral(resourceName: "no_image")
        }
        
        if item.state == .none {
            statusLabel.alpha = 0
        } else {
            statusLabel.apply {
                $0.alpha = 1
                $0.text = item.state.fetchNaming()
                $0.backgroundColor = item.state.fetchColor()
            }
        }
        
        nameLabel.text = item.name
        priceLabel.text = "Цена: \(item.price)"
        
        return self
    }
    
    @discardableResult
    func layout(isEditing: Bool) -> CGFloat {
        
        return 60
    }
}
