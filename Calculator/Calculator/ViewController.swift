//
//  ViewController.swift
//  Calculator
//
//  Created by Emiralp Duman on 29.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Main output label
    @IBOutlet weak var mainOutput: UILabel!
    
    var currentInput: String = "0" {
        didSet {
            mainOutput.text = currentInput
        }
    }
    
    var decimalChoice: Int = 0
    var currentOperation: Operation?
    
    enum Operation {
        case sum, subtract, multiply, divide
    }
    
    //Keeps record of all clicked numbers in an array
    var recordedNumbers: [Double] = []
    
    //Gets the input from number and digit buttons and writes them on currentInput label
    @IBAction func getInput(_ sender: UIButton) {
        guard let input = sender.currentTitle else {
            fatalError("Number or digit buttons' label is nil")
        }
        if currentInput == "0" {
            currentInput.removeAll()
        }
        currentInput.append(input)
    }
    
    //Converts current input to double and stores in "recordedNumbers", changes current operation to .sum
    @IBAction func sum(_ sender: UIButton) {
        guard let currentInputInDouble = Double(currentInput) else {
            fatalError("Current input cannot be converted into a double number.")
        }
        currentOperation = .sum
        recordedNumbers.append(currentInputInDouble)
        let recordedNumber: String = currentInput
        currentInput = "0"
        mainOutput.text = recordedNumber

    }
    
    //Ends current operation and returns result to mainOutput label.
    @IBAction func equals(_ sender: UIButton) {
        guard let currentInputInDouble = Double(currentInput) else {
            fatalError("Current input cannot be converted into a double number.")
        }
        guard let lastRecordedNumber = recordedNumbers.last else {
            currentInput = "0"
            return
        }
        switch currentOperation {
        case .sum:
            mainOutput.text = String(lastRecordedNumber + currentInputInDouble)
        case .subtract:
            break
        case .multiply:
            break
        case .divide:
            break
        case .none:
            break
        }
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        currentOperation = nil
        currentInput = "0"
    }
}

