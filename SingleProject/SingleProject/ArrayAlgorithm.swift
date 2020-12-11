//
//  ArrayAlgorithm.swift
//  SingleProject
//
//  Created by Alex on 2020/11/21.
//

import Foundation
/* 二位数组的查找
 一个二维数组，每一行左到右递增，上到下递增，给定一个数，判断这个数是否在数组中
 返回值:true--查找到了，false--没有查找到
*/
func findValue(array: [[Int]], value: Int) -> Bool {
    if array.count == 0 || array[0].count == 0 {
        return false
    }
    let rows = array.count
    let columns = array[0].count
    var row = 0
    var column = columns-1
    //从第一行最后一个数开始比较，比value大，则column减一，比value小，则row加一
    while row < rows && column >= 0 {
        if array[row][column] > value {
            column -= 1
        }else if array[row][column] < value {
            row += 1
        }else {
            return true
        }
    }
    
    return false
}
/* 数组中重复的数字
  在一个长度为n的数组中，数子从0到n-1，寻找重复的数字
  返回值:-1--错误，重复的数字
*/
func duplicate(array:inout [Int]) -> Int {
    for item in array {
        assert(item < array.count, "错误的数字")
    }
    
    for index in 0..<array.count {
        //当index位置处不是值为index
        while array[index] != index {
            //(array[index])位置处也是值array[index]
            if array[array[index]] == array[index] {
                return array[index]
            //交换位置(array[index])处和index处的值
            //优先赋值(array[index])处的值
            }else {
                let temp = array[array[index]]
                array[array[index]] = array[index]
                array[index] = temp
            }
        }
    }
    return -1
}

/* 构建乘积数组
 给定数组A[0,1,...,n-1]
 构建数组B[0,1,...,n-1]
 其中B[i]=A[0]A[1]...A[i-1]A[i+1]...A[n-1]
 不能使用除法
 返回值:B[]
*/
func multiply(arrayA:[Int]) -> [Int] {
    if arrayA.count <= 0 {
        return []
    }
    var arrayB = Array(repeating: 1, count: arrayA.count)
    //前(index-1)个值的积
    for index in 1..<arrayA.count {
        arrayB[index] = arrayB[index-1] * arrayA[index-1]
    }
    //后(arrayA.count-index-1)个的积,循环从倒数第二个值开始
    var temp = 1
    for index in stride(from: arrayA.count-2, through: 0, by: -1) {
        temp *= arrayA[index+1]
        arrayB[index] *= temp
    }
    return arrayB
}
/* 调整数组顺序使奇数位于偶数前面
 返回值: 调整后的数组
*/
func reOrderArray(array: inout [Int]){
    array.sort(by: {(a1, a2) -> Bool in
        a1 % 2 == 1 && a2 % 2 == 0
    })
}

/* 顺时针打印矩阵
 如 [1, 2, 3, 4
    10,11,12,5
    9, 8, 7, 6]
 打印：1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
 返回值:无
 */
func printMatrix(array: [[Int]]) -> [Int] {
    if array.count <= 0 || array[0].count <= 0 {
        print("空矩阵")
        return []
    }
    var result = [Int]()
    var rowStart = 0, rowEnd = array.count-1
    var columnStart = 0, columnEnd = array[0].count-1
    //遍历所有的行和列
    while rowStart <= rowEnd && columnStart <= columnEnd {
        //上面rowStart行的遍历
        for index in columnStart...columnEnd {
            result.append(array[rowStart][index])
        }
        
        //右边columnEnd列的遍历
        if rowStart < rowEnd { //防止最后一个时越界
            for index in (rowStart+1)...rowEnd {
                result.append(array[index][columnEnd])
            }
        }
    
        //下面rowEnd行的遍历
        if rowStart != rowEnd { //防止同一行时左右重复遍历
            for index in stride(from: columnEnd-1, through: columnStart, by: -1) {
                result.append(array[rowEnd][index])
            }
        }
        
        //左边columnStart列的遍历
        if columnStart != columnEnd { //防止同一列时上下重复遍历
            for index in stride(from: rowEnd-1, through: rowStart+1, by: -1) {
                result.append(array[index][columnStart])
            }
        }
        rowStart += 1; rowEnd -= 1; columnStart += 1; columnEnd -= 1
    }
    return result
}

/* 连续子数组的最大和
 给定一个数组，包含正负数，求连续子数组中的最大和
 返回值:最大和的值
*/
func findGreatestSumOfSubArray(array: [Int]) -> Int {
    var maxValue = Int(INT8_MIN)
    if array.count <= 0 {
        return maxValue
    }
    var sum = 0
    for item in array {
        //连续元素相加的和，如sum<0,则从当前元素重新计算
        sum = sum < 0 ? item : (sum + item)
        //maxValue为sum和上一个maxValue的最大值
        maxValue = max(sum, maxValue)
    }
    return maxValue
}

/* 把数组排成最小的数
 一个正整数数组，把数组所有数字拼接起来排成一个数，输出最小的数
 返回值: 最小的数对应字符串
*/
func printMinNumber(array: inout [UInt]) -> String {
    //排好序，使字符串值小的数字排在最前面
    array.sort { (a1, a2) -> Bool in
        String(a1) + String(a2) < String(a2) + String(a1)
    }
    var result = ""
    //拼接成最小数的字符串值
    for item in array {
        result += String(item)
    }
    return result
}
