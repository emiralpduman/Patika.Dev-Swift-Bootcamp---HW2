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
    
    var currentInput: String = "" {
        didSet {
            mainOutput.text = currentInput
        }
    }
    
    //Keeps record of all clicked numbers in an array
    var selectedNumbers: [Float] = []
    
    //Gets the input from number and digit buttons and writes them on currentInput label
    @IBAction func getInput(_ sender: UIButton) {
        guard let input = sender.currentTitle else {
            fatalError("Number or digit buttons' label is nil")
        }
        currentInput.append(input)
    }
    
    


}

