//
//  ProductShopCell.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 22.03.2021.
//

import UIKit
import RxSwift

final class ProductShopCell: UICollectionViewCell {
    private let bag = DisposeBag()
    private var item: ProductShopModel!
    var onTapBuy: Action<ProductShopModel>?
    
    private lazy var buyButton: UIButton = {
        let button = UIButton(type: .system).apply {
            $0.setTitle("Купить", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = MainTheme.shared.selectedColor
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            $0.layer.cornerRadius = 8
        }
        
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.onTapBuy?(self.item)
            })
            .disposed(by: bag)
        
        addSubview(button)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: Configure
    
    @discardableResult
    func configure(_ item: ProductShopModel) -> ProductShopCell {
        self.item = item
        return self
    }
    
    @discardableResult
    func layout() -> CGFloat {
        
        buyButton.pin
            .top(24)
            .horizontally(15)
            .height(50)
        
        return buyButton.frame.maxY
    }
}
