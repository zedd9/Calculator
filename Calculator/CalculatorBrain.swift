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
	
	func setOperand(operand: Double) {
		accumulator = operand
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
	
	var result: Double{
		get {
			return accumulator
		}
	}
}
