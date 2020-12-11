//
//  StackAlgorithm.swift
//  SingleProject
//
//  Created by Alex on 2020/12/5.
//

import Foundation

/* 用两个栈实现队列
 inStack处理入栈(push)操作
 outStack处理出栈(pop)操作
 */
class queueWithTwoStack {
    var inStack: [Int] = Array()
    var outStack: [Int] = Array()
    
    func push(node: Int) {
        inStack.append(node)
    }
    
    func pop() ->Int? {
        if inStack.isEmpty && outStack.isEmpty {
            return nil
        }
        if outStack.isEmpty {
            while !inStack.isEmpty {
                outStack.append(inStack.popLast()!)
            }
        }
        return outStack.popLast()
    }
}

/* 包含min函数的栈
 */
class includeMinStack {
    var dataStack: [Int] = Array()
    var minStack: [Int] = Array()
    
    func push(node: Int) {
        dataStack.append(node)
        if minStack.isEmpty || node < min()! {
            minStack.append(node)
        }else {
            let temp = min()!
            minStack.append(temp)
        }
    }
    
    func pop() {
       let _ = dataStack.popLast()
       let _ = minStack.popLast()
    }
    
    func top() -> Int? {
        if dataStack.isEmpty {
            return nil
        }
        return dataStack[dataStack.endIndex-1]
    }
    
    func min() -> Int? {
        if minStack.isEmpty {
            return nil
        }
        
        return minStack[minStack.endIndex-1]
    }
}

/* 栈的压入、弹出序列
 输入两个整数序列，第一个序列表示栈的压入顺序，请判断第二个序列是否为该栈的弹出顺序
*/
func isPopOrder(pushV: [Int], popV: inout [Int]) -> Bool {
    if pushV.isEmpty || popV.isEmpty {
        return false
    }
    
    var stack: [Int] = Array()
    for value in pushV {
        stack.append(value)
        while !stack.isEmpty && stack[stack.endIndex-1] == popV[0] {
            let _ = stack.popLast()
            let _ = popV.removeFirst()
        }
    }
    if stack.isEmpty {
        return true
    }
    return false
}
