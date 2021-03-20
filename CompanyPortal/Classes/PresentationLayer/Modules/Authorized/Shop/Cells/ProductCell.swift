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
        contentView.backgroundColor = MainTheme.shared.baseColor
    }

    // MARK: Configure
    
    @discardableResult
    func configure(_ item: ProductModel) -> ProductCell {
        productImageView.image = item.productImage ?? #imageLiteral(resourceName: "no_image")
        statusLabel.text = item.status?.uppercased()
        nameLabel.text = item.name
        priceLabel.text = item.price
        return self
    }
    
    @discardableResult
    func layout(isEditing: Bool) -> CGFloat {
        
        return 60
    }
}
