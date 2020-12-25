//
//  ViewController.swift
//  Calculator
//
//  Created by Hyeonuk Shin on 2020/12/18.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet private weak var display: UILabel!
	
	private var userIsIntheMiddleOfTyping : Bool = false
	
	@IBAction private func touchDigit(_ sender: UIButton) {
		let digit = sender.currentTitle!
		
		if userIsIntheMiddleOfTyping {
			let textCurrentlyInDisplay = display.text!
			display.text = textCurrentlyInDisplay + digit
		} else {
			display.text = digit
		}
		
		userIsIntheMiddleOfTyping = true
	}
	
	private var displayValue : Double{
		get{
			return Double(display.text!)!
		}
		set{
			display.text = String(newValue)
		}
	}
	
	var savedProgram: CalculatorBrain.PropertyList?
	
	@IBAction func save(_ sender: UIButton) {
		savedProgram = brain.program
	}
	
	@IBAction func restore(_ sender: UIButton) {
		if savedProgram != nil {
			brain.program = savedProgram!
			displayValue = brain.result
		}
	}
	
	
	private var brain = CalculatorBrain()
	
	@IBAction private func performOperation(_ sender: UIButton) {
		if userIsIntheMiddleOfTyping {
			brain.setOperand(operand: displayValue)
			userIsIntheMiddleOfTyping = false
		}
	
		if let mathematicalSymbol = sender.currentTitle {
			brain.performOperation(symbol: mathematicalSymbol)
		}
		
		displayValue = brain.result
	}
}

