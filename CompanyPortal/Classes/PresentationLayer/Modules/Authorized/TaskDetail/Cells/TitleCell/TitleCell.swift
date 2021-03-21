//
//  TitleCell.swift
//  CompanyPortal
//
//  Created by Vladimir Golovkin on 21.03.2021.
//

import UIKit

final class TitleCell: UICollectionViewCell {

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
    
    private lazy var statusView: UIView = {
        let theme = MainTheme.shared.self
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
        statusView.addSubview(label)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    // MARK: Configure
    
    @discardableResult
    func configure(_ item: TaskTitle) -> TitleCell {
        nameLabel.text = item.title
        statusView.backgroundColor = item.status.fetchColor()
        statusLabel.text = item.status.fetchNaming()
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

        statusLabel.pin
            .all(3)
            .sizeToFit(.widthFlexible)
        
        statusView.pin
            .wrapContent(padding: .init(top: 2, left: 8, bottom: 2, right: 8))
        
        return statusView.frame.maxY
    }
}
