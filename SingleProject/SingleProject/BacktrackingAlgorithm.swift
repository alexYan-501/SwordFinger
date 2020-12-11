//
//  BacktrackingAlgorithm.swift
//  SingleProject
//
//  Created by Alex on 2020/12/11.
//

import Foundation
/* 矩阵中的路径
 判断在一个矩阵中是否存在一条包含某字符串所有字符的路径
 每一步可以在矩阵中向左、向右、向上、向下移动, 不能重复进入某一个格子
 如:
     a b c e
     s f c s
     a d e e
矩阵包含字符串"bcced"的路径, 但不包含字符串"abcb"路径
 */
class MatrixPath {
    var rows = 0
    var columns = 0
    var next = [[0, -1], [0, 1], [-1, 0], [1, 0]]
    
    func hasPath(matrix: [[String]], str: String) -> Bool {
        if matrix.isEmpty || str.isEmpty     {
            return false
        }
        rows = matrix.count
        columns = matrix[0].count
        var marked = Array.init(repeating: Array.init(repeating: false, count: columns), count: rows)
        for i in 0..<rows {
            for j in 0..<columns {
                if backtracking(&marked, str, matrix, 0, i, j) {
                    return true
                }
            }
        }
        return false
    }
    
    private func backtracking(_ marked: inout [[Bool]], _ str: String, _ matrix: [[String]], _ pathLen: Int, _ r: Int, _ c: Int) ->Bool {
        //str中所有字符比对完成
        if pathLen == str.count {
            return true
        }
        if r < 0 || r >= rows ||
           c < 0 || c >= columns ||
           (matrix[r][c] != String(str[str.index(str.startIndex, offsetBy: pathLen)])) ||
           marked[r][c] {
            return false
        }
        marked[r][c] = true
        for value in next {
            if backtracking(&marked, str, matrix, pathLen + 1, r + value[0], c + value[1]) {
                return true
            }
        }
        marked[r][c] = false
        return false
    }
}
