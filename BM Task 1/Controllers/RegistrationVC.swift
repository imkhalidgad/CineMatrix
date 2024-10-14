//
//  RegistrationVC.swift
//  BM Task 1
//
//  Created by Mahmoud Elsharkawy on 19/07/2024.
//

import UIKit

class RegistrationVC: UIViewController {
    
    
    // MARK: - IbOutlets
    @IBOutlet weak var regImg: UIImageView!
    
    @IBOutlet weak var regNameTxtField: UITextField!
    
    @IBOutlet weak var regEmailTxtField: UITextField!
    
    @IBOutlet weak var regPassTxtField: UITextField!
    
    @IBOutlet weak var regRePasstxtField: UITextField!
    
    @IBOutlet weak var regPhoneTxtField: UITextField!
    
    @IBOutlet weak var regAddressTxtField: UITextField!
    
    @IBOutlet weak var registerBTN: UIButton!
    
    override func viewDidLoad() {
    
        registerBTN.layer.cornerRadius = 30
        registerBTN.layer.masksToBounds = true

        super.viewDidLoad()
        
    }
   
    
    // MARK: - IbActions
    @IBAction func getRegImg(_ sender: Any) {
        showImgAlert()
       // regImg.layer.cornerRadius = regImg.frame.height/2
    }
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        if isValidData() {
            let user = getUserData()
            if let confirmPassword = regRePasstxtField.text, isPasswordConfirmed(password: user.password, confirmPssword: confirmPassword) {
                saveUserDataToDefaults(user: user)
                self.goToLoginScreen(user: user)
            }
        }
        
    }
    // MARK: - funcShowImgALert
    func showImgAlert() {
        let alert = UIAlertController(title: "Take image from:", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.getImg(type: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { action in
            self.getImg(type: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
//MARK: - privateFunctions
extension RegistrationVC{
    private func goToLoginScreen(user: User) {
        let sb = UIStoryboard(name: StoryBoards.main, bundle: nil)
        let logVC = sb.instantiateViewController(withIdentifier: VCs.login) as! LoginVC
        logVC.user = user
        self.navigationController?.pushViewController(logVC, animated: true)
    }
    
    private func getUserData() -> User {
        let user = User(image: regImg.image!, name: regNameTxtField.text!, email: regEmailTxtField.text!, password: regPassTxtField.text!, phone: regPhoneTxtField.text!, address: regAddressTxtField.text!)
        return user
    }
    private func isPasswordConfirmed(password: String, confirmPssword: String) -> Bool {
        if password == confirmPssword {
            return true
        } else {
            self.showALert(title: "Sorry", message: "The Password isn't confirmed successfuly")
            return false
        }
    }
   
    private func isValidData() -> Bool{
        guard regImg.image != UIImage(systemName: "person.crop.circle.fill.badge.plus") else {
            self.showALert(title: "Sorry", message: "Please Add Profile Pic!")
            return false
        }
        guard regNameTxtField.text?.trimmed != ""  else {
            self.showALert(title: "Sorry", message: "Please enter your name!")
            return false
      
        }
        guard let email = regEmailTxtField.text?.trimmed, !email.isEmpty , isValidEmail(email) else {
            self.showALert(title: "Sorry", message: "Please enter your valid email!")
            return false
              }
        guard let password = regPassTxtField.text?.trimmed , !password.isEmpty , isValidPassword(password) else {
            self.showALert(title: "Sorry", message: "Please enter your valid password!")
            return false
              }
        guard let confirmPassword = regRePasstxtField.text?.trimmed, !confirmPassword.isEmpty, isValidPassword(confirmPassword)  else {
            self.showALert(title: "Sorry", message: "Please Confirm your valid password!")
            return false
      
        }
        guard let phone = regPhoneTxtField.text?.trimmed, !phone.isEmpty, isValidEgyptianPhoneNumber(phone) else {
            self.showALert(title: "Sorry", message: "Please enter your phone!")
            return false
      
        }
        guard regAddressTxtField.text?.trimmed != "" else {
            self.showALert(title: "Sorry", message: "Please enter your address!")
            return false
      
        }
        return true
    }
    //MARK: -saveDataToUD
    private func saveUserDataToDefaults(user: User) {
        let defaults = UserDefaults.standard
        defaults.set(user.name, forKey: "userName")
        defaults.set(user.email, forKey: "userEmail")
        defaults.set(user.password, forKey: "userPassword")
        defaults.set(user.phone, forKey: "userPhone")
        defaults.set(user.address, forKey: "userAddress")
        if let imageData = user.image.jpegData(compressionQuality: 1.0) {
            defaults.set(imageData, forKey: "userImage")
        }
        
    }
    
    //MARK: -RegexFunctions
    private func isValidEmail(_ email: String) -> Bool {
        // "[a-z._%+a-z-0-9]+@[A-Za-z0-9.-]+\\.(com|net|org)$" (Common) edited by me
        // "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          let emailRegex =  "[a-z._%+a-z-0-9]+@[A-Za-z0-9.-]+\\.(com|net|org)$"
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
          return emailTest.evaluate(with: email)
      }
      
      private func isValidPassword(_ password: String) -> Bool {
          let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}$"
          // "([(A-Z)(!@#.$%ˆ&*+-=<>)(0-9)]+)([a-z]*){8,15}"
          // "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
          let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
          return passwordTest.evaluate(with: password)
      }
      
      private func isValidEgyptianPhoneNumber(_ phone: String) -> Bool {
          let phoneRegex = "^(010|011|012|015)\\d{8}$"
          let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
          return phoneTest.evaluate(with: phone)
      }
}

// MARK: - ImagePicker
    extension RegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        func getImg(type: UIImagePickerController.SourceType){
            let picker = UIImagePickerController()
            picker.sourceType = type
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            dismiss(animated: true, completion: nil)
            guard let image = info[.editedImage] as? UIImage else{return}
            self.regImg.image = image
            
            
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    }

