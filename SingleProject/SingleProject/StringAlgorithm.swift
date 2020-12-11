//
//  StringAlgorithm.swift
//  SingleProject
//
//  Created by Alex on 2020/11/21.
//

import Foundation

/* 替换空格
 将一个字符串中的每个空格替换为"%20"
 返回值：替换空格后的字符串
*/
func replaceSpace(original: String) -> String {
    //使用原生API
    //return original.replacingOccurrences(of: " ", with: "%20")
    //遍历，替换空格
    var newStr = ""
    for index in original.indices {
        if original[index] == " " {
            newStr.append("%20")
        }else {
            newStr.append(original[index])
        }
    }
    return newStr
}

/* 正则匹配
 模式包含"."和"*","."表示当前字符为任意值，"*"表示前面的字符可以出现任意次(包括0次)
 1.匹配值为空，模式值为空---true
 2.匹配值不为空，模式值为空--- false
 3.匹配值为空，模式值不为空
  3.1 模式值的第二个字符为"*",则递归匹配匹配值和模式值中"*"后面的值
  3.2 模式值的第二个字符不为"*"---false
 4.匹配值不为空，模式值不为空
  4.1 模式值的第二个字符为"*"
    4.1.1 匹配值的第一个字符和模式值的第一个字符不相等，且模式值的第一个字符不为".",
          则匹配值递归匹配模式"*"后面的字符
    4.1.2 匹配值的第一个字符和模式值的第一个字符相同，或模式值的第一个字符为"."
      4.1.2.1 匹配值与模式值"*"后的字符递归匹配
      4.1.2.2 匹配值第一个字符后的字符与模式值中"*"后的字符递归匹配
      4.1.2.3 匹配值第一个字符后的字符与模式值递归匹配
  4.2 模式值的第二个字符不为"*"
    4.2.1 匹配值的第一个字符和模式值的第一个字符相等，或模式值的第一个字符为".",则递归匹配后续的字符
    4.2.1 匹配值的第一个字符和模式值的第一个字符不相等，且模式值的第一个字符不为"." ---false
 返回值: true--匹配，false--不匹配
*/
func match(str: String, pattern: String) -> Bool {
    //模式为空,匹配值不为空
    if pattern.isEmpty && !str.isEmpty {
        return false
    }
    //模式和匹配值都为空
    else if pattern.isEmpty && str.isEmpty {
        return true
    }
    //匹配值为空，模式不为空
    else if str.isEmpty && pattern.count > 0 {
        //模式中第二个值为"*",则继续匹配后面的值
        if pattern.count > 1 && pattern[pattern.index(after: pattern.startIndex)] == "*" {
            let firstIndex = pattern.firstIndex(of: "*")
            return match(str: str, pattern: String(pattern[pattern.index(after:firstIndex!)...]))
        }
    }
    //匹配值和模式都不为空
    else {
        //模式中第二个为"*"
        if pattern.count > 1 && pattern[pattern.index(after: pattern.startIndex)] == "*" {
            //匹配值第一个字符和模式值的第一个字符不相等，且模式值的第一个字符不为"."
            let firstIndex = pattern.firstIndex(of: "*")
            if str[str.startIndex] != pattern[pattern.startIndex] &&
                pattern[pattern.startIndex] != "."{
                let subPattern = pattern[pattern.index(after: firstIndex!)...]
                return match(str: str, pattern: String(subPattern))
            }else {
                let firstSubStr = String(str[str.index(after: str.startIndex)...])
                let firstSubPattern = String(pattern[pattern.index(after: firstIndex!)...])
                return match(str: str, pattern: firstSubPattern) ||
                    match(str: firstSubStr, pattern: firstSubPattern) ||
                    match(str: firstSubStr, pattern: pattern)
            }
        }
        //模式中第二个不为"*"
        else {
            //匹配值第一个值跟模式相等，或者模式中第一个值为".",继续匹配
            if str[str.startIndex] == pattern[pattern.startIndex] ||
                pattern[pattern.startIndex] == "." {
                let subStr = str[str.index(after: str.startIndex)...]
                let subPattern = pattern[pattern.index(after: pattern.startIndex)...]
                return match(str: String(subStr), pattern: String(subPattern))
            }
        }
    }
    return false
}

/* 表示数值的字符串
 字符串包括整数和小数
 1.考虑"+"、"-"符号
  1.1 符号出现一次，且不在第一位，或"E"、"e"的后面---false
  1.2 符号出现两次，且不在"E"、"e"的后面---false
 2.考虑"E"、"e"符号
  2.1 出现一次，不能为最后一个---false
  2.2 出现两次---false
 3.考虑"."符号
  3.1 出现两次---false
  3.2 出现一次，前面出现"E"、"e"---false
 4.其它非数字---false
 返回值: true--数值，false--不是数值
*/
func isNumeric(str: String) -> Bool {
    if str.isEmpty {
        return false
    }
    var has_sign = false, has_e = false, has_point = false
    for index in str.indices {
        //"+"或"-"符号
        if str[index] == "+" || str[index] == "-" {
            if has_sign {
                //第二个"+"或"-"必须在"e"或"E"后面
                if str[str.index(before: index)] != "e" && str[str.index(before: index)] != "E" {
                    return false
                }
            }else {
                has_sign = true
                if index != str.startIndex &&
                    (str[str.index(before: index)] != "e"
                    && str[str.index(before: index)] != "E") //不是第一个且前一个不是"E"或"e"
                {
                    return false
                }
            }
        }
        //"E"或"e"符号
        else if str[index] == "E" || str[index] == "e" {
            if has_e { //出现两次
                return false
            }else {
                has_e = true
                if index == str.endIndex { //"E"或"e"为最后一个
                    return false
                }
            }
        }
        //"."符号
        else if str[index] == "." {
            if has_point { //出现两次
                return false
            }else {
                has_point = true
                if has_e { //出现在"E"或"e"的后面
                    return false
                }
            }
        }else {
            //其它非数字字符
            if str[index] < "0" || str[index] > "9" {
                return false
            }
        }
    }
    return true
}

/* 字符流中第一个不重复的字符
 dic---插入字符出现的次数哈希表
 ary---存储只出现一次的字符
 找出字符流中第一个只出现一次的字符
 */

struct Solution {
    var dic = [Character : Int]()
    var ary = [Character]()
    
    mutating func firstAppearingOnce() -> Character {
        if self.ary.count == 0 {
            return "#"
        }else {
            return self.ary[0]
        }
    }
    
    mutating func insert(char: Character) {
        //若哈希表中没有，存储当前字符，并作为
        if !self.dic.keys.contains(char) {
            self.dic[char] = 1
            self.ary.append(char)
        }else {
            self.dic[char] = 2
            //删除出现两次以上的字符
            if (self.ary.firstIndex(of: char) != nil) {
                self.ary.remove(at: self.ary.firstIndex(of: char)!)
            }
        }
    }
}

/* 字符串的排列
 输入一个字符串(可能有重复字符)，按字典序打印出该字符串中字符的所有排列
 如：输入abc，则打印：abc, acb, bac, bca, cab, cba
 1.空字符串，直接返回[]
 2.一个字符，直接返回[str]
 3.多个字符
  3.1 字符串转换为数组，并对数组排序
  3.2 对排序后的数组，递归交换第一个字符的位置，完成拼接
 返回值: 所有的排列数组
 注意：时间复杂度O(n^2)
*/
func permutation(str: String) -> [String] {
    if str.isEmpty {
        return []
    }else if str.count == 1 {
        return [str]
    }
    //字符串转成数组
    var list = str.map { (char) -> String in
        String(char)
    }
    //数组中字符按字典顺序排列
    list.sort()
    var pStr = [String]()
    for i in 0..<list.count {
        //重复的字符时无需拼接
        if i > 0 && list[i] == list[i-1] {
            continue
        }
        //递归找出除list[i]字符的字典序首个字符
        let temp = permutation(str: (list[..<i].joined(separator: ""))+list[(i+1)...].joined(separator:""))
        for j in temp {
            pStr.append(list[i]+j)
        }
    }
    return pStr
}
