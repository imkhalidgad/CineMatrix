import UIKit
import MarqueeLabel

class LoginVC: UIViewController {

    var user: User!
    
    // MARK: - IBOutlets
    @IBOutlet weak var logEmailTxtField: UITextField!
    @IBOutlet weak var logPassTxtField: UITextField!
    
    @IBOutlet weak var loginBTN: UIButton!
    @IBOutlet weak var tryLabel: MarqueeLabel!
    
    override func viewDidLoad() {
        
        loginBTN.layer.cornerRadius = 25
        loginBTN.layer.masksToBounds = true
        // Check if the user is already logged in
        super.viewDidLoad()
        
    }
    // MARK: - IBActions
    @IBAction func loginBtnTapped(_ sender: Any) {
        guard let email = logEmailTxtField.text, let password = logPassTxtField.text else { return }
        if validateLoginData(email: email, password: password) {
            navigateToMediaScreen()
        } else {
            showALert(title: "Sorry", message: "Please Enter valid info")
        }
    }
    
    // MARK: - Validation
    private func validateLoginData(email: String, password: String) -> Bool {
        let defaults = UserDefaults.standard
        if let storedEmail = defaults.string(forKey: "userEmail"),
           let storedPassword = defaults.string(forKey: "userPassword"),
           email == storedEmail && password == storedPassword {
            return true
        }
        return false
    }
    
    // MARK: - User Management
    private func loadUserFromUserDefaults() -> User {
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "userName") ?? ""
        let email = defaults.string(forKey: "userEmail") ?? ""
        let password = defaults.string(forKey: "userPassword") ?? ""
        let phone = defaults.string(forKey: "userPhone") ?? ""
        let address = defaults.string(forKey: "userAddress") ?? ""
        var image: UIImage = UIImage(systemName: "person.fill")!
        if let imageData = defaults.data(forKey: "userImage") {
            image = UIImage(data: imageData) ?? UIImage(systemName: "person.fill")!
        }
        return User(image: image, name: name, email: email, password: password, phone: phone, address: address)
    }
                      
    private func navigateToMediaScreen() {
        let sb = UIStoryboard(name: StoryBoards.main, bundle: nil)
        let mediaVC = sb.instantiateViewController(withIdentifier: VCs.mediaList) as! MediaVC
            mediaVC.user = loadUserFromUserDefaults()
        self.navigationController?.pushViewController(mediaVC, animated: true)
        }
   
    
}
