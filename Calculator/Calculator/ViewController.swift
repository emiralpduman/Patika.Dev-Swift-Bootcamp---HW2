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
    
    //Presents main output
    @IBOutlet weak var mainOutput: UILabel!
    
    //Presents historical output
    @IBOutlet weak var historicalOutput: UILabel!
    
    //Ongoing input instance from user
    var currentInput: String = "0" {
        didSet {
            mainOutput.text = currentInput
        }
    }
    
    //Decimal digit count of user's input
    var decimalChoice: Int = 0
    
    //Ongoing calculation operation. Sum, subtract etc.
    var currentOperation: Operation?
    
    //Last completed calculation
    var lastEquation: (Double, Double, Operation, Double)? {
        didSet {
            var operationText:String = ""
            if let lastEquation = lastEquation {
                switch lastEquation.2 {
                case .sum:
                    operationText = "+"
                case .subtract:
                    operationText = "-"
                case .multiply:
                    operationText = "*"
                case .divide:
                    operationText = "/"
                }
                currentInput = "0"
                historicalOutput.text = "\(lastEquation.0)\(operationText)\(lastEquation.1) = \(lastEquation.3)"
            } else {
                historicalOutput.text = ""
            }
        }
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
    @IBAction func operate(_ sender: UIButton) {
        if let operation = sender.currentTitle {
            
            
            if let previousOperation = currentOperation {
                guard let currentInputInDouble = Double(currentInput) else {
                    fatalError("Current input cannot be converted into a double number.")
                }
                guard let lastRecordedNumber = recordedNumbers.last else {
                    currentInput = "0"
                    return
                }
                
                var result: Double = .zero
                switch currentOperation {
                case .sum:
                    result = lastRecordedNumber + currentInputInDouble
                case .subtract:
                    result = lastRecordedNumber - currentInputInDouble
                case .multiply:
                    result = lastRecordedNumber * currentInputInDouble
                case .divide:
                    result = lastRecordedNumber / currentInputInDouble
                case .none:
                    break
                }
                lastEquation = (lastRecordedNumber, currentInputInDouble, previousOperation, result)
                recordedNumbers.append(result)
                mainOutput.text = String(result)
                
                if operation == "+" {
                    currentOperation = .sum
                }
                if operation == "-" {
                    currentOperation = .subtract
                }
                if operation == "*" {
                    currentOperation = .multiply
                }
                if operation == "/" {
                    currentOperation = .divide
                }
                
            } else {
                if operation == "+" {
                    currentOperation = .sum
                }
                if operation == "-" {
                    currentOperation = .subtract
                }
                if operation == "*" {
                    currentOperation = .multiply
                }
                if operation == "/" {
                    currentOperation = .divide
                }
                
                guard let currentInputInDouble = Double(currentInput) else {
                    fatalError("Current input cannot be converted into a double number.")
                }
                recordedNumbers.append(currentInputInDouble)
                let recordedNumber: String = currentInput
                currentInput = "0"
                mainOutput.text = recordedNumber
                
            }
        }
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
        guard let operation = currentOperation else {
            return
        }
        var result: Double = .zero
        switch currentOperation {
        case .sum:
            result = lastRecordedNumber + currentInputInDouble
        case .subtract:
            result = lastRecordedNumber - currentInputInDouble
        case .multiply:
            result = lastRecordedNumber * currentInputInDouble
        case .divide:
            result = lastRecordedNumber / currentInputInDouble
        case .none:
            break
        }
        currentOperation = nil
        lastEquation = (lastRecordedNumber, currentInputInDouble, operation, result)
        mainOutput.text = String(result)
    }
    
    //Clears and resets the calculator
    @IBAction func reset(_ sender: UIButton) {
        currentOperation = nil
        currentInput = "0"
        lastEquation = nil
    }
    
    //Changes the sign of current user input
    @IBAction func toggleSign(_ sender: UIButton) {
        guard let currentInputInDouble = Double(currentInput) else {
            return
        }
        currentInput = String(currentInputInDouble * -1)
    }
    
    //Percentage operation. Acts different if there is ongoing calculation.
    @IBAction func percentage(_ sender: UIButton) {
        guard let currentInputInDouble = Double(currentInput) else {
            return
        }
        if currentOperation != nil {
            guard let lastRecordedNumber = recordedNumbers.last else {
                return
            }
            let baseNumber = lastRecordedNumber
            let newOperand = currentInputInDouble * baseNumber / 100
            currentInput = String(newOperand)
        } else {
            currentInput = String(currentInputInDouble / 100)
        }
    }
    
    //Square root operation. Acts different if there is ongoing calculation.
    @IBAction func squareRoot(_ sender: UIButton) {
        guard let currentInputInDouble = Double(currentInput) else {
            return
        }
        if currentOperation != nil {
            let newOperand = currentInputInDouble.squareRoot()
            currentInput = String(newOperand)
        } else {
            currentInput = String(currentInputInDouble.squareRoot())
        }
    }
    
    //Square operation. Acts different if there is ongoing calculation.
    @IBAction func square(_ sender: UIButton) {
        guard let currentInputInDouble = Double(currentInput) else {
            return
        }
        if currentOperation != nil {
            let newOperand = currentInputInDouble * currentInputInDouble
            currentInput = String(newOperand)
        } else {
            currentInput = String(currentInputInDouble * currentInputInDouble)
        }
    }
    
    //Factorial. operation. Acts different if there is ongoing calculation.
    @IBAction func factorial(_ sender: UIButton) {
        guard let currentInputInDouble = Double(currentInput) else {
            return
        }
        if currentOperation != nil {
            let newOperand: Int
            var result: Int = 1
            for number in 1...Int(currentInputInDouble.rounded()) {
                result *= number
            }
            newOperand = result
            currentInput = String(newOperand)
        } else {
            var result: Int = 1
            for number in 1...Int(currentInputInDouble.rounded()) {
                result *= number
            }
            currentInput = String(result)
        }
    }
    
}
