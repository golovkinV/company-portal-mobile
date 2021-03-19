//
//  UserInfoContainerCell.swift
//  call-center
//
//  Created by MintRocket on 12.11.2020.
//

import UIKit
import PinLayout

final class UserInfoContainerCell: BaseCollectionViewCell {
    
    private weak var delegate: UserInfoContainerCellDelegate?
    
    private let flowLayout = UICollectionViewFlowLayout().apply {
        $0.scrollDirection = .vertical
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: flowLayout)
    private var item: ProfileInfoContainer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    override func adapterCreators() -> [AdapterCreator] {
        [
            UserInfoCellAdapterCreator(delegate: delegate),
            LogoutCellAdapterCreator(delegate: delegate)
        ]
    }
    
    // MARK: Configure

    @discardableResult
    func setDelegate(_ delegate: UserInfoContainerCellDelegate?) -> UserInfoContainerCell {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func configure(_ item: ProfileInfoContainer) -> UserInfoContainerCell {
        self.item = item
        items = item.items
        update(animated: false)
        return self
    }

    func layout() {
        collectionView.pin.all()
    }

    
    // MARK: - Private
        
    private func setupViews() {
        
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        collectionView.apply {
            $0.backgroundColor = MainTheme.shared.white
            $0.clipsToBounds = true
        }
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        
        addSubview(collectionView)
    }
}
