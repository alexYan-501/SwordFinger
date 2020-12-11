//
//  DPAlgorithm.swift
//  SingleProject
//
//  Created by Alex on 2020/12/5.
//

import Foundation

/* 正则表达式匹配
 实现一个函数用来匹配包括"."和"*"的正则表达式
 "."表示任意一个字符
 "*"表示它前面的字符可以出现任意次(包含0次)
 例如: "aaa"与模式"a.a"和"ab*ac*a"匹配, 与"aa.a"和"ab*a"均不匹配
*/
func matchStrWithPattern(str: String?, pattern: String?) -> Bool {
    if pattern == nil || pattern!.isEmpty {
        return false
    }
    if str == nil || str!.isEmpty {
        return true
    }
    
    func customIndex(_ theString: String, _ offsetBy: Int) -> String.Index
    {
        return theString.index(theString.startIndex, offsetBy: offsetBy)
    }
    
    let m = str!.count, n = pattern!.count
    //n列
    let columns = Array.init(repeating: false, count: n+1)
    //m行
    var dp: [[Bool]] = Array.init(repeating: columns, count: m+1)
    dp[0][0] = true
    
    for i in 1...n {
        if pattern![customIndex(pattern!, i-1)] == "*" {
            dp[0][i] = dp[0][i-2]
        }
    }
    
    for i in 1...m {
        for j in 1...n {
            if str![customIndex(str!, i-1)] == pattern![customIndex(pattern!, j-1)] || pattern![customIndex(pattern!, j-1)] == "." {
                dp[i][j] = dp[i-1][j-1]
            }else if pattern![customIndex(pattern!, j-1)] == "*" {
                if pattern![customIndex(pattern!, j-2)] == str![customIndex(str!, i-1)] ||
                   pattern![customIndex(pattern!, j-2)] == "."
                {
                    dp[i][j] != dp[i][j-1]
                    dp[i][j] != dp[i-1][j]
                    dp[i][j] != dp[i][j-2]
                }else {
                    dp[i][j] = dp[i][j-2]
                }
            }
        }
    }
    return dp[m][n]
}

/*斐波那契数列
 f(0) = 0, f(1) = 1, f(2) = 1
 f(n) = f(n-1) + f(n-2)
 */
func fabonacci(n: Int) -> Int {
    if n <= 1 {
        return n
    }
    var pre2 = 0, pre1 = 1
    var fib = 0
    for _ in 2...n {
        fib = pre2 + pre1
        pre2 = pre1
        pre1 = fib
        
    }
    return fib
}

/* 跳台阶
 青蛙一次可以跳上一级台阶，也可以跳上两级台阶，求青蛙跳上n级台阶总共有多少种方法
 函数f(n)
 1级台阶: f(1) = 1
 2级台阶: f(2) = 2(每次跳一级+直接跳两级)
 则n级台阶可以考虑为: 青蛙先跳1级，再跳剩下的(n-1)级和先跳2级, 再跳剩下的(n-2)级
 n级台阶: f(n) = f(n-1) + f(n-2)
 */
func jumpSteps(n: UInt) -> UInt {
    if  n <= 2{
        return n
    }
    var pre2: UInt = 2, pre1: UInt = 1
    var sum: UInt = 0
    for _ in 3...n {
        sum = pre2 + pre1
        pre1 = pre2
        pre2 = sum
        
    }
    return sum
}
class DPAndRecursion {
    let isDP = false
    
    /* 变态跳台阶
     一只青蛙一次可以跳上1级台阶，也可以跳上2级......它也可以跳上n级
     求该青蛙跳上一个n级的台阶总共有多少种方法
     n > 1
     f(n-1) = f(n-2)+f(n-3)+...+f(0)
     f(n)   = f(n-1)+f(n-2)+...+f(0)
     f(n)-f(n-1) = f(n-1)
     f(n) = 2*f(n-1)
    */
    func jumpStepsII(n: Int) -> Int {
        if isDP {
            var dp = Array.init(repeating: 1, count: n)
            if n < 1 {
                return 0
            }
            for i in 1..<n {
                //第i个等于0~i-1的和
                for j in 0..<i {
                    dp[i] += dp[j]
                }
            }
            return dp[n-1]
        }else {
            if n <= 2 {
                return n
            }
            return 2*jumpStepsII(n: n-1)
        }
    }
    
    /* 矩形覆盖
     用2*1的小矩形横着或者竖着去覆盖更大的矩形
     用n个2*1的小矩形无重叠地覆盖一个2*n的大矩阵，总共有多少种方法
     1.竖着覆盖，覆盖一个，还剩n-1个覆盖
     2.横着覆盖，一次需要2组(2*1)覆盖，还剩n-2个覆盖
     f(n) = f(n-1) + f(n-2)
    */
    func rectCover(n: Int) -> Int {
        if isDP {
            if n <= 2 {
                return n
            }
            var pre1 = 1, pre2 = 2
            var sum = 0
            for _ in 3...n {
                sum = pre1 + pre2
                pre1 = pre2
                pre2 = sum
            }
            return sum
        }else {
            if n <= 2 {
                return n
            }
            return rectCover(n: n-1) + rectCover(n: n-2)
        }
    }
}

/* 二进制中1的个数
 输入一个整数，输出该数二进制表示中1的个数
 三十二位整数二进制:
 1.正数(5): 00000000 00000000 00000000 00000101
 2.负数(-5)
  2.1 绝对值的二进制数: 00000000 00000000 00000000 00000101
  2.2 对2.1的数取反: 11111111 11111111 11111111 11111010
  2.3 对2.2的数加1: 11111111 11111111 11111111 11111011
 */
func binaryNumberOf1(n: Int) ->UInt {
    var sum: UInt = 0
    var m = n
    if m < 0 {
        m &= 0xffffffff
    }
    while m != 0 {
        sum += 1
        m &= (m-1)
    }
    return sum
}

/* 丑数
 把只包含质因子2、3和5的数称作丑数
 习惯上把1当做是第一个丑数
 求按从小到大的顺序的第n个丑数
 质因子: 能整除给定正整数的质数
*/
func uglyNumber(n: Int) -> Int {
    assert(n>0, "fatal error: Can't input less 1")
    var ugly_number = Array.init(repeating: 1, count: n)
    var next_index = 1
    var index2 = 0, index3 = 0, index5 = 0
    while next_index < n {
        let min_value = min(ugly_number[index2]*2, ugly_number[index3]*3, ugly_number[index5]*5)
        ugly_number[next_index] = min_value
        if ugly_number[index2]*2 <= min_value {
            index2 += 1
        }
        if ugly_number[index3]*3 <= min_value {
            index3 += 1
        }
        if ugly_number[index5]*5 <= min_value {
            index5 += 1
        }
        next_index += 1
    }
    return ugly_number[n-1]
}

