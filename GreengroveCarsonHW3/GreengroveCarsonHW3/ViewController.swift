//
//  ViewController.swift
//  GreengroveCarsonHW3
//
//  Created by Student on 9/16/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var whichOne: UILabel!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var sunDog: UIButton!
    @IBOutlet weak var sadDog: UIButton!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var chooseOp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        whichOne.accessibilityIdentifier = HW3AccessibilityIdentifiers.titleLabel
        textBox.accessibilityIdentifier = HW3AccessibilityIdentifiers.nameTextField
        sunDog.accessibilityIdentifier = HW3AccessibilityIdentifiers.optionButton1
        sadDog.accessibilityIdentifier = HW3AccessibilityIdentifiers.optionButton2
        chooseOp.accessibilityIdentifier = HW3AccessibilityIdentifiers.outputLabel
        reset.accessibilityIdentifier = HW3AccessibilityIdentifiers.resetButton

        textBox.delegate = self
        sunDog.imageView?.contentMode = .scaleAspectFit
        sadDog.imageView?.contentMode = .scaleAspectFit
        
    }

    @IBAction func pressSunDog(_ sender: UIButton) {
        let name = textBox.text ?? ""
        if name.count > 0
        {
            chooseOp.text = "\(name), chose the sunglass dog!"
        }
        else{
            chooseOp.text = "You chose the sunglass dog!"
        }
        
    }
    @IBAction func pressSadDog(_ sender: UIButton) {
        let name = textBox.text ?? ""
        if name.count > 0{
            chooseOp.text = "\(name), chose the sad dog."
        }
        else{
            chooseOp.text = "You chose the sad dog."
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textBox.resignFirstResponder()
        return true
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        textBox.text = ""
        chooseOp.text = "Choose an option"
    }
    @IBAction func tapBack(_ sender: UITapGestureRecognizer) {
        textBox.resignFirstResponder()
    }
}

