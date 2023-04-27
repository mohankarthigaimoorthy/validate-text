//
//  ViewController.swift
//  validateText
//
//  Created by Mohan K on 19/12/22.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: DTTextField!
    @IBOutlet weak var lastNameTextField: DTTextField!
    @IBOutlet weak var emailIdTextField: DTTextField!
    @IBOutlet weak var passWordTextField: DTTextField!
    @IBOutlet weak var confirmPasswordTextField: DTTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let firstNameMessage        = NSLocalizedString("First name is required.", comment: "")
    let lastNameMessage         = NSLocalizedString("Last name is required.", comment: "")
    let emailMessage            = NSLocalizedString("Email is required.", comment: "")
    let passwordMessage         = NSLocalizedString("Password is required.", comment: "")
    let confirmPasswordMessage  = NSLocalizedString("Confirm password is required.", comment: "")
    let mismatchPasswordMessage = NSLocalizedString("Password and Confirm password are not matching.", comment: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        submitButton.layer.cornerRadius = 8
        
        
        
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    
    
    @IBAction func onBtnClickedSubmit(_ sender: Any) {
        
        guard validateData() else { return }
        
        let alert = UIAlertController(title: "Congratulations", message: "Your registration is successful!!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (cancel) in
            DispatchQueue.main.async { self.clearForm() }
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func clearForm() {
        self.firstNameTextField.text = ""
        self.lastNameTextField.text = ""
        self.emailIdTextField.text = ""
        self.passWordTextField.text = ""
        self.confirmPasswordTextField.text = ""
    }
    
}


extension ViewController {
    @objc func keyboardWillShow(notification:Notification) {
           guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
           scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight.height, right: 0)
       }
       
       @objc func keyboardWillHide(notification:Notification) {
           scrollView.contentInset = .zero
       }
       
    
    
    func validateData() -> Bool {
        
        guard !firstNameTextField.text!.isEmptyStr else {
            firstNameTextField.showError(message: firstNameMessage)
            return false
        }
        
        guard !lastNameTextField.text!.isEmptyStr else {
            lastNameTextField.showError(message: lastNameMessage)
        return false
            
        }
        
        guard !emailIdTextField.text!.isEmptyStr else{
            emailIdTextField.showError(message: emailMessage)
            return false
        }
        
        guard !passWordTextField.text!.isEmptyStr else{
            passWordTextField.showError(message: passwordMessage)
            return false
        }
        
        guard !confirmPasswordTextField.text!.isEmptyStr else{
            confirmPasswordTextField.showError(message: confirmPasswordMessage)
            return false
        }
        
        guard passWordTextField.text == confirmPasswordTextField.text else{
            confirmPasswordTextField.showError(message: mismatchPasswordMessage)
            return false
        }
        return true
    }
}
