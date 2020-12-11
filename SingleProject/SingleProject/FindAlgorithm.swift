//
//  FindAlgorithm.swift
//  SingleProject
//
//  Created by Alex on 2020/11/23.
//

import Foundation

/* 旋转数组的最小数字
 输入一个非减排序的数组的一个旋转，输出旋转数组的最小元素
 NOTE: 给出的所有元素都大于0，若数组大小为0，则返回0
 1.数组为空数组---返回0
 2.非空数组，通过二分查找方法查找最小元素
 返回值: 最小元素或0
*/
func minNumberInRotateArray(ary: [Int]) -> Int {
    if ary.isEmpty {
        return 0
    }
    //折半查找
    var front = 0, rear = ary.endIndex - 1
    var minVal = ary[0]
    //未旋转状态,无需折半查找
    if ary[front] < ary[rear] {
        return ary[front]
    }
    //折半查找
    while rear-front > 1 {
        let mid = (rear + front) / 2
        //中间的比前面的大，说明最小值在后半部分
        if ary[mid] >= ary[front] {
            front = mid
        }
        //中间的比后面的小，说明最小值在前半部分
        else if ary[mid] <= ary[rear] {
            rear = mid
        }
        //若前面的值，中间的值和最后的值相等，则无法确认区间，直接遍历求最小值
        else if ary[front] == ary[mid] && ary[mid] == ary[rear] {
            for value in ary {
                if minVal > value {
                    minVal = value
                    rear = ary.firstIndex(of: value)!
                }
            }
        }
    }
    minVal = ary[rear]
    return minVal
}

/* 数字在排序数组中出现的次数
 统计一个数字在排序(升序)数组中出现的次数
 返回值: 重复的次数
*/
func repeatTimesOfK(ary: [Int], k: Int) -> Int {
    if ary.isEmpty {
        return 0
    }
    //查找第一个为k值的index
    func firstIndexOfk() -> Int {
        var front = 0
        var rear = ary.endIndex-1
        //折半查找最右边的k的index
        while rear >= front {
            let mid = (rear + front) / 2
            if ary[mid] > k {
                rear = mid - 1
            }else if ary[mid] < k {
                front = mid + 1
            }else {
                //k为数组中最左边一个，或者左边不再存在k
                if mid == front || ary[mid - 1] != k {
                    return mid
                }else {
                    rear = mid - 1
                }
            }
        }
        return -1
    }
    //查找最后一个为k值的index
    func lastIndexOfk() -> Int {
        var low = 0, high = ary.endIndex-1
        while high >= low {
            let mid = (high + low) / 2
            if ary[mid] > k {
                high = mid - 1
            }else if ary[mid] < k {
                low = mid + 1
            }else {
                //k为数组中右边一个，或k的右边不存在k值了
                if high == mid || ary[mid + 1] != k {
                    return mid
                }else {
                    low = mid + 1
                }
                
            }
        }
        return -1
    }
    //当第一个k值和最后一个k值的index都没有时，返回0
    if firstIndexOfk() == -1 && lastIndexOfk() == -1 {
        return 0
    }
    //加1是由于index是从0开始，并保证只有一个k值时的次数为1
    return lastIndexOfk() - firstIndexOfk() + 1
}
