//
//  MaxBaseVC.swift
//  Max
//
//  Created by Rahul on 12/12/21.
//

import UIKit

class MaxBaseVC: UIViewController {
    
    //MARK:-IBOutlet

    lazy var blurredView: UIView = {
        // 1. create container view
        let containerView = UIView()
        // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .regular)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.08)
        customBlurEffectView.frame = self.view.bounds
        // 3. create semi-transparent black view
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.2)
        dimmedView.frame = self.view.bounds
        
        // 4. add both as subviews
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    //MARK:-Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:-Action
    @IBAction func btnBackTapped(_ sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
