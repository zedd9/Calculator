//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Hyeonuk Shin on 2020/12/18.
//

import Foundation

class CalculatorBrain
{
	private var accumulator = 0.0
	private var internalProgram = [Any]()
	
	func setOperand(operand: Double) {
		accumulator = operand
		internalProgram.append(operand)
	}
	
	private var operations: Dictionary<String,Operation> = [
		"π" : Operation.Constant(Double.pi),
		"e" : Operation.Constant(M_E),
		"±" : Operation.UnaryOperation({ -$0 }),
		"√" : Operation.UnaryOperation(sqrt),
		"cos" : Operation.UnaryOperation(cos),
		"×" : Operation.BinaryOperation({ $0 * $1 }),
		"÷" : Operation.BinaryOperation({ $0 / $1 }),
		"+" : Operation.BinaryOperation({ $0 + $1 }),
		"-" : Operation.BinaryOperation({ $0 - $1 }),
		"=" : Operation.Equals
	]
	
	private enum Operation {
		case Constant(Double)
		case UnaryOperation((Double) -> Double)
		case BinaryOperation((Double, Double) -> Double)
		case Equals
	}
	
	func performOperation(symbol: String){
		internalProgram.append(symbol)
		if let operation = operations[symbol] {
			switch operation {
			case .Constant(let value):
				accumulator = value
			case .UnaryOperation(let function):
				accumulator = function(accumulator)
			case .BinaryOperation(let function):
				excutePendingBinaryOperation()
				pending = PendingBinarayOperationInfo(binarayFunction: function, firstOperand: accumulator)
			case .Equals:
				excutePendingBinaryOperation()
			}
		}
	}
	
	private func excutePendingBinaryOperation()
	{
		if pending != nil {
			accumulator = pending!.binarayFunction(pending!.firstOperand, accumulator)
		}
	}
	
	private var pending: PendingBinarayOperationInfo?
	
	private struct PendingBinarayOperationInfo {
		var binarayFunction: (Double, Double) -> Double
		var firstOperand: Double
	}
	
	typealias PropertyList = Any
	var program: PropertyList {
		get {
			return internalProgram
		}
		set {
			clear()
			if let arrayOfops = newValue as? [Any] {
				for op in arrayOfops {
					if let operand = op as? Double {
						setOperand(operand: operand)
					} else if let operation = op as? String {
						performOperation(symbol: operation)
					}
				}
			}
		}
	}
	
	func clear() {
		accumulator = 0.0
		pending = nil
		internalProgram.removeAll()
	}
	
	var result: Double{
		get {
			return accumulator
		}
	}
}
