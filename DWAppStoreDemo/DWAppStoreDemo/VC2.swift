//
//  VC2.swift
//  AppStoreDemo
//
//  Created by Crazy Davy on 2018/11/15.
//  Copyright © 2018 Crazy Davy. All rights reserved.
//

import UIKit

class VC2: UIViewController {
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let contentCard = UIView()
    let cardView = CardView()
    let contentLab = UILabel()
    let scrollView = UIScrollView()
//    let ges: UIPanGestureRecognizer = {
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
//        return pan
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        scrollView.backgroundColor = .clear
        
        cardView.titleLabel.text = "🤪"
        cardView.subtitleLabel.text = "CrazyDavy"
        
        contentLab.numberOfLines = 0
        contentLab.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent neque est, hendrerit vitae nibh ultrices, accumsan elementum ante. Phasellus fringilla sapien non lorem consectetur, in ullamcorper tortor condimentum. Nulla tincidunt iaculis maximus. Sed ut urna urna. Nulla at sem vel neque scelerisque imperdiet. Donec ornare luctus dapibus. Donec aliquet ante augue, at pellentesque ipsum mollis eget. Cras vulputate mauris ac eleifend sollicitudin. Vivamus ut posuere odio. Suspendisse vulputate sem vel felis vehicula iaculis. Fusce sagittis, eros quis consequat tincidunt, arcu nunc ornare nulla, non egestas dolor ex at ipsum. Cras et massa sit amet quam imperdiet viverra. Mauris vitae finibus nibh, ac vulputate sapien.
        """
        
        contentCard.backgroundColor = .white
        contentCard.clipsToBounds = true
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 500)
        scrollView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
//        scrollView.bounces = false
        
        contentCard.addSubview(contentLab)
        contentCard.addSubview(cardView)
        scrollView.addSubview(contentCard)
        view.addSubview(visualEffectView)
        view.addSubview(scrollView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
        cardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:))))
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        var translation = gr.translation(in: view)
        translation.y = translation.y > 0 ? translation.y : -translation.y // 取绝对值
        switch gr.state {
        case .began:
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.y / view.bounds.height)
        default:
            var velocity = gr.velocity(in: view)
            velocity.y = velocity.y > 0 ? velocity.y : -velocity.y // 取绝对值
            if ((translation.y + velocity.y) / view.bounds.height) > 0.5 {
                Hero.shared.finish()
                print("finish")
            } else {
                Hero.shared.cancel()
                print("cancel")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let bounds = view.bounds
        visualEffectView.frame  = bounds
        scrollView.frame = bounds
        contentCard.frame  = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + 500)
        cardView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        contentLab.frame = CGRect(x: 20, y: bounds.width + 20, width: bounds.width - 40, height: bounds.height - bounds.width - 20)
    }
    
    @objc func onTap() {
        dismiss(animated: true, completion: nil)
    }
}
