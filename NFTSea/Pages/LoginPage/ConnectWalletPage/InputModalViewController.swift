//
//  InputModalViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/16/22.
//

import UIKit

class InputModalViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var dismissButton: UIButton!
    
    var placeholderLabel : UILabel!
    
    var secretKey: String = ""
    var privateKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
        setupFirstTextView()
        
        firstTextView.delegate = self
        secondTextView.delegate = self
        
        importButton.layer.cornerRadius = 20
    }
    
    private func setupSegmentedControl () {
        segControl.setTitle("Secret Key", forSegmentAt: 0)
        segControl.setTitle("Private Key", forSegmentAt: 1)
    }
    
    private func setupFirstTextView () {
        secondTextView.isHidden = true
        
        firstTextView.isHidden = false
        firstTextView.backgroundColor = UIColor(red: 145/255, green: 150/255, blue: 190/255, alpha: 1.0)
        firstTextView.layer.cornerRadius = 5
        firstTextView.text = "12 word recovery phrase"
        firstTextView.textColor = .lightGray
    }
    private func setupSecondTextView() {
        firstTextView.isHidden = true
        firstTextView.text = nil
        
        secondTextView.isHidden = false
        secondTextView.backgroundColor = UIColor(red: 145/255, green: 150/255, blue: 190/255, alpha: 1.0)
        secondTextView.layer.cornerRadius = 5
        secondTextView.text = "64 alphanumeric characters"
        secondTextView.textColor = .lightGray
    }
    
    
    @IBAction func didChangeSegment(_ sender: Any) {
        switch segControl.selectedSegmentIndex {
        case 0:
            setupFirstTextView()
            break
        case 1:
            setupSecondTextView()
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
        if textView.text.isEmpty {
            print("textview is empty")
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
        
        secretKey = firstTextView.text!
        privateKey = secondTextView.text!
        
        guard (secretKey != "" || privateKey != "") else {
            showAlert(title: "Signin alert", message: "Forget to fill your secret key")
            return
        }
        
        importExistingWallet(name: "", email: "", mnemonics: secretKey, pKey: privateKey)
        
        navigateWithFirebase()
    }
    
    func navigateWithFirebase() {
        let docRef = firestore.collection("users").document(currentUser.uid)
        docRef.getDocument { responses, error in
            if ((responses?.exists) != nil){
                let profileVC = storyBoard.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
                self.navigationController?.isNavigationBarHidden = true
//                self.present(profileVC, animated: true, completion: nil)
                self.navigationController!.pushViewController(profileVC, animated: true)
                
            } else {
                docRef.setData(["email": currentUser.email, "name": currentUser.userName, "uid": currentUser.uid])

                let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.pushViewController(loginVC, animated: true)
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
