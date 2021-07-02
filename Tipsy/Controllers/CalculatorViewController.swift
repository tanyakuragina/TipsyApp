//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController:
    UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var buttonPressedName: String?
    var tip = 0.1
    var peopleAmount: Int? = 2
    var total = "0.0"
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false;
        tenPctButton.isSelected = false;
        twentyPctButton.isSelected = false;
        
        if (sender.isSelected) {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        
        buttonPressedName = sender.currentTitle!
        
        let pureNumber = String(buttonPressedName!.dropLast())
       
        let titleAsANumber = Double(pureNumber)!
        
        tip = titleAsANumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
        peopleAmount = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let tipAmount = Double(billTextField.text!)! * Double(tip)
        let sum = Double(billTextField.text!)! + tipAmount
        let dividedSum = sum / Double(peopleAmount!)
        total = String(format: "%.2f", dividedSum)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destination = segue.destination as! ResultsViewController
            destination.total = total
            destination.text = "Split between \(peopleAmount!) people, with \(buttonPressedName!)"
        }
    }
}

