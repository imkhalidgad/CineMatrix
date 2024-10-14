//
//  profileVC.swift
//  BM Task 1
//
//  Created by Mahmoud Elsharkawy on 19/07/2024.
//

import UIKit

class ProfileVC: UIViewController {

    var user: User!
    
    @IBOutlet weak var profImg: UIImageView!
    
    @IBOutlet weak var profName: UITextField!
    
    @IBOutlet weak var profEmail: UITextField!
    
    @IBOutlet weak var profPhone: UITextField!
    
    @IBOutlet weak var profAddress: UITextField!
   
    @IBOutlet weak var logOutBTN: UIButton!
    override func viewDidLoad() {
        
        profImg.layer.cornerRadius = profImg.frame.height/2
        logOutBTN.layer.cornerRadius = 25
        logOutBTN.layer.masksToBounds = true
    
        super.viewDidLoad()
        
        setupProfile()
    }
    

    @IBAction func logoutBtnTapped(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.switchToAuthState()
        
//        showLogoutAlert {
//            self.logoutUser()
//                }
    }
    
    private func setupProfile() {
        guard let user = user else { return }
        profImg.image = user.image
        profName.text = user.name
        profEmail.text = user.email
        profPhone.text = user.phone
        profAddress.text = user.address
    }
}

// MARK: - Logout
//extension ProfileVC {
//    private func logoutUser() {
//           
//           let defaults = UserDefaults.standard
//           defaults.removeObject(forKey: "userName")
//           defaults.removeObject(forKey: "userEmail")
//           defaults.removeObject(forKey: "userPassword")
//           defaults.removeObject(forKey: "userPhone")
//           defaults.removeObject(forKey: "userAddress")
//           defaults.removeObject(forKey: "userImage")
//    }
//}
