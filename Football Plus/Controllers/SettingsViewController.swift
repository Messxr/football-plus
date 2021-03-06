//
//  SupportViewController.swift
//  Football Plus
//
//  Created by Даниил Марусенко on 09.10.2020.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var supportButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var bottomNavBarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBG(bottomNavBarImage)
        
        updateButton(rateButton)
        updateButton(supportButton)
        updateButton(privacyPolicyButton)
    }
    
    @IBAction func rateButtonPressed(_ sender: UIButton) {
        rateApp()
    }
    
    @IBAction func supportButtonPressed(_ sender: UIButton) {
        if let url = URL(string: "") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func privacyPolicyPressed(_ sender: UIButton) {
        if let url = URL(string: "") {
            UIApplication.shared.open(url)
        }
    }
    
    func rateApp() {
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    func updateButton(_ button: UIButton) {
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 2
    }
    
}
