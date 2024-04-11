//
//  NewNameVC.swift
//  HW8
//
//  Created by Margarita Can on 9.04.2024.
//

import UIKit


final class SecondVC: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    
    @IBOutlet private weak var lastNameTextField: UITextField!
    
    @IBOutlet private  weak var cancelButton: UIButton!
    
    @IBOutlet private weak var saveButton: UIButton!
    
    weak var delegate: AddPersonDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        
    }
    
    @IBAction func saveButttonDidTap(_ sender: Any) {
        guard let name = nameTextField.text,
              let lastName = lastNameTextField.text,
              !name.isEmpty,
              !lastName.isEmpty
        else { return }
        let newPerson = Person (name: name, lastName: lastName)
        delegate?.configure(person: newPerson)
        dismiss(animated: true)
    }
    
    @IBAction private func cancelButtonDidTap(_ sender: Any) {
        dismiss (animated: true)
        
    }
}
extension SecondVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            lastNameTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
    }
}
protocol AddPersonDelegate: AnyObject {
    func configure (person: Person)
}
