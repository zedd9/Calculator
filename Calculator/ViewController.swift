//
//  ViewController.swift
//  Calculator
//
//  Created by Hyeonuk Shin on 2020/12/18.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var display: UILabel!
	
	var userIsIntheMiddleOfTyping : Bool = false
	
	@IBAction func touchDigit(_ sender: UIButton) {
		let digit = sender.currentTitle!
		
		if userIsIntheMiddleOfTyping {
			let textCurrentlyInDisplay = display.text!
			display.text = textCurrentlyInDisplay + digit
		} else {
			display.text = digit
		}
		
		userIsIntheMiddleOfTyping = true
	}
	
	@IBAction func performOperation(_ sender: UIButton) {
		userIsIntheMiddleOfTyping = false
		
		if let mathematicalSymbol = sender.currentTitle {
			if mathematicalSymbol == "π"{
				display.text = String(Double.pi)
			}
		}
	}
}

