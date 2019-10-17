//
//  AnnonceCell.swift
//  Le bon coin
//
//  Created by mbdse on 17/10/2019.
//  Copyright © 2019 Tokidev S.A.S. All rights reserved.
//

import UIKit

class AnnonceCell: UICollectionViewCell {
    
    var annonce: Annonce? {
        didSet {
            setAnonnce()
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.mainOrange()
        return label
    }()
    
    let offerLabel: UILabel = {
        let label = UILabel()
        label.text = "Offer"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let priceLabel: UILabel = {
    let label = UILabel()
    label.text = "Price"
    label.font = UIFont.boldSystemFont(ofSize: 12)
    return label
    }()
    
    
    
    
    fileprivate func setAnonnce() {
        guard let annonce = annonce else { return }
        
        titleLabel.text = annonce.title
        offerLabel.text = annonce.offer
        priceLabel.text = annonce.price
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCellUI()
    }
    
    fileprivate func setupCellUI() {
        addSubview(titleLabel)
        addSubview(offerLabel)
        addSubview(priceLabel)
        
        backgroundColor = .white
        
         titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 6, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        offerLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        priceLabel.anchor(top: offerLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        
    }
        
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
