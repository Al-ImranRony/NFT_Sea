//
//  InputModalViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/16/22.
//

import UIKit
import FirebaseFirestore


class InputModalViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var dismissButton: UIButton!
    
    var placeholderLabel : UILabel!
    
    var secretKey: String = ""
    var privateKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
        setupTextView()
        
        inputTextView.delegate = self
        
        importButton.layer.cornerRadius = 20
    }
    
    private func setupSegmentedControl () {
        segControl.setTitle("Secret Key", forSegmentAt: 0)
        segControl.setTitle("Private Key", forSegmentAt: 1)
    }
    
    private func setupTextView () {
        inputTextView.isHidden = false
        inputTextView.backgroundColor = UIColor(red: 145/255, green: 150/255, blue: 190/255, alpha: 1.0)
        inputTextView.layer.cornerRadius = 5
        inputTextView.textColor = .lightGray
        if (inputTextView.text.isEmpty) {
            inputTextView.text = "12 word recovery phrase"
        }
    }
    
    
    
    @IBAction func didChangeSegment(_ sender: Any) {
        switch segControl.selectedSegmentIndex {
        case 0:
            setupTextView()
            inputTextView.text = "12 word recovery phrase"
            break
        case 1:
            setupTextView()
            inputTextView.text = "64 alphanumeric characters"
            break
        default:
            break
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if (textView.textColor == UIColor.lightGray) {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        switch segControl.selectedSegmentIndex {
        case 0:
            secretKey = inputTextView.text!
            break
        case 1:
            privateKey = inputTextView.text!
            break
        default:
            break
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    @IBAction func didPressImportWallet(_ sender: Any) {
        
        guard (secretKey != "" || privateKey != "") else {
            showAlert(title: "Signin alert", message: "Forget to fill your secret key")
            return
        }
        
        importExistingWallet(name: "", email: "", mnemonics: secretKey, pKey: privateKey)
        
        navigateWithFirebase()
    }
    
    func navigateWithFirebase() {
        let docRef = firestore.collection("users").document(currentUser.uid!)
        let fireStorage = 
        
        docRef.getDocument { responses, error in
            if ((responses?.exists) != false){
                let profileVC = storyBoard.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
                let navController = UINavigationController(rootViewController: profileVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
                
            } else {
                docRef.setData(["email": currentUser.email, "name": currentUser.userName, "user_DP": currentUser.userDP, "uid": currentUser.uid])
                
                let profileVC = storyBoard.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
                let navController = UINavigationController(rootViewController: profileVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didPressNeverMind(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}


public func showAlert(title:String, message:String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    
    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController()
    alertWindow.windowLevel = UIWindow.Level.alert + 1;
    alertWindow.makeKeyAndVisible()
    alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
}
