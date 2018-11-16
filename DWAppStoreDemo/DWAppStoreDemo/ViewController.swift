//
//  ViewController.swift
//  DWAppStoreDemo
//
//  Created by Crazy Davy on 2018/11/16.
//  Copyright © 2018 Crazy Davy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [String] = {
        var array = [String]()
        for i in 0...10 {
            array.append("Unsplash\(i)")
        }
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as! Cell1
        cell.roundView.cardView.imageView.image = UIImage(named: dataSource[indexPath.row])
        cell.roundView.cardView.subtitleLabel.text = "CrazyDavy"
        cell.roundView.cardView.titleLabel.text = "🤩🥳🤯"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Cell1
        transformCell(cell: cell, x: 0.95, y: 0.95)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Cell1
        transformCell(cell: cell, x: 1, y: 1)
    }
    
    func transformCell(cell: Cell1 ,x: CGFloat ,y: CGFloat) { // transform
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: x, y: y)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            cell.roundView.transform = transform
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Cell1
        transformCell(cell: cell, x: 1, y: 1) // 还原
        
        let cardHeroId = "card\(indexPath.row)" // 绑定id
        cell.roundView.cardView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 200, damping: 20)]
        cell.roundView.cardView.hero.id = cardHeroId
        
        let vc = VC2()
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .none
        
        vc.cardView.hero.id = cardHeroId
        vc.cardView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 200, damping: 20)]
        vc.cardView.imageView.image = UIImage(named: dataSource[indexPath.row])
        
        vc.contentCard.hero.modifiers = [.source(heroID: cardHeroId), .spring(stiffness: 200, damping: 20)]
        vc.contentLab.hero.modifiers = [.useNoSnapshot, .forceAnimate, .spring(stiffness: 200, damping: 20)]
        vc.visualEffectView.hero.modifiers = [.fade, .useNoSnapshot]
        
        present(vc, animated: true, completion: nil)
    }
}

class Cell1: UICollectionViewCell {
    @IBOutlet weak var roundView: RoundedCardWrapperView!
}


