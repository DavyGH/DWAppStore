//
//  CardView.swift
//  AppStoreDemo
//
//  Created by Crazy Davy on 2018/11/15.
//  Copyright © 2018 Crazy Davy. All rights reserved.
//

import UIKit

class CardView: UIView {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Unsplash6"))
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        addSubview(visualEffectView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        visualEffectView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 90)
        titleLabel.frame = CGRect(x: 20, y: 20, width: bounds.width - 40, height: 30)
        subtitleLabel.frame = CGRect(x: 20, y: 50, width: bounds.width - 40, height: 30)
    }
}

class RoundedCardWrapperView: UIView {
    let cardView = CardView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cardView.layer.cornerRadius = 16
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 8)
        
        addSubview(cardView)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        cardView.layer.cornerRadius = 16
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 8)
        
        addSubview(cardView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if cardView.superview == self { // 区分cardView是在VC1还是VC2中
            cardView.frame = bounds
        }
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
