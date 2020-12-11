//
//  LinkedListAlgorithm.swift
//  SingleProject
//
//  Created by Alex on 2020/11/24.
//

import Foundation

class LinkNode: Equatable {
    static func == (lhs: LinkNode, rhs: LinkNode) -> Bool {
        var newlhs: LinkNode? = lhs, newrhs: LinkNode? = rhs
        
        while newrhs != nil && newlhs != nil {
            if newrhs!.data != newlhs!.data {
                return false
            }
            newrhs = newrhs!.next
            newlhs = newlhs!.next
            if (newrhs != nil && newrhs!.data! == lhs.data) {
                return true
            }
        }
        if newrhs == nil && newlhs == nil {
            return true
        }
        return false
    }
    
    var data: Int!
    var next: LinkNode?
}

class List {
    //创建list
    func addListTill(linkedList: inout LinkNode?, data: Int) {
        if linkedList == nil {
            linkedList = LinkNode()
            linkedList!.data = data
            linkedList!.next = nil
        }else {
            let newNode = LinkNode()
            newNode.data = data
            newNode.next = nil
            var node = linkedList
            //遍历到最后结点
            while node != nil {
                //node为最后结点时
                if node?.next == nil {
                    node?.next = newNode
                    break
                }else {
                    node = node?.next
                }
            }
        }
        
    }
    
    /* 从尾到头打印链表*/
    func printListFromTallToHead(list: LinkNode?) {
        if list == nil {
            print("空链表")
            return
        }
        let head = LinkNode()
        var node = list
        //头插法构建逆序列表
        while node != nil {
            //暂存node的next结点
            let temp = node?.next
            //node结点的next指针指向head的next指针指向的结点
            node?.next = head.next
            //head的next指针指向新结点node，完成插入
            head.next = node
            //遍历到下一个结点
            node = temp
        }
        node = head.next
        //打印逆序链表
        while node != nil {
            print("\(node!.data!)")
            node = node?.next
        }
    }
    
    //寻找环链表中的结点
    func findLoopListEntryNode(list: LinkNode?) -> LinkNode? {
        if list == nil || list?.next == nil {
            return nil
        }
        var low = list, quick = list
        //判断是否有环
        repeat {
            low = low?.next
            quick = quick?.next?.next
        }while(low != quick)
        //链表没有环
        if low == nil {
            return nil
        }
        return low
    }
    //以结点值为k的点创建环,若有环不创建
    func createLoopLinkedList(list: LinkNode?, k: Int) {
        if list == nil {
            return
        }
        let node = findLoopListEntryNode(list: list)
        var kNode = list
        if node == nil {
            var end = list
            while end?.next != nil {
                if end?.data == k {
                    kNode = end
                }
                end = end?.next
            }
            if kNode != nil {
                end?.next = kNode
            }
        }
    }
    
    /* 链表中环的入口结点
     1.空链表和一个结点链表--无环
     2.结点两个以上
      2.1 通过快慢指针(慢指针每次走一步，快指针每次走两步)，查找相遇结点
       2.1.1 无相遇结点---无环
       2.1.2 有相遇结点，则再次通过两个结点迭代，一个从头结点出发，一个从相遇点出发，
             两个结点相遇的结点就是环入口结点
     返回值：没有环，返回nil,有环，返回对应结点*/
    func entryNodeOfLoop(list: LinkNode?) -> LinkNode? {
        if list == nil || list?.next == nil {
            return nil
        }
        let meetNode = findLoopListEntryNode(list: list)
        if meetNode != nil {
            var low = list, fast = meetNode
            while low != fast {
                low = low?.next
                fast = fast?.next
            }
            return fast
        }
        return nil
    }
    
    /* 删除链表中重复的结点
     在一个排序的链表中存在重复的结点，删除该链表中重复的结点
     1.空链表和一个结点链表--无重复数据
     2.两个结点以上
      2.1 头结点跟下一个结点相同，则迭代查询到最后相同的结点，递归查询除相同后的链表
      2.2 头结点跟下一个结点不同，则头结点直接指向next后的删除重复结点
     返回值: 删除重复结点后的链表
    */
    func deleteDuplication(list: LinkNode?) -> LinkNode? {
        //空链表或一个结点链表
        if list == nil || list?.next == nil {
            return list
        }
        var next = list?.next
        //头结点给后续结点相同情况
        if list?.data == next?.data {
            while next != nil && list?.data == next?.data {
                next = next?.next
            }
            return deleteDuplication(list: next)
        }
        //头结点跟next结点不同的情况
        else {
            list?.next = deleteDuplication(list: list?.next)
        }
        return list
    }
    
    /* 链表中倒数第k个结点
       1.链表为空或k值小于0时--返回空
       2.链表不为空时，指定两个指针
        2.1 先让一个指针遍历到第k个位置
         2.1.1 若不存在k个位置--返回空
         2.1.2 若存在
          2.1.2.1 则两个指针同时遍历，当从k位置处遍历到尾结点时，则头结点开始遍历的刚好到达k结点处
      返回值: 空或者第k个结点
    */
    func findKthToTill(list: LinkNode?, k: Int) -> LinkNode? {
        if list == nil || k <= 0 {
            return nil
        }
        var pFirst = list
        var pSecond: LinkNode?
        //遍历到k个位置
        for _ in 0..<k {
            if pFirst != nil {
                pFirst = pFirst?.next
            }else {
                return nil
            }
        }
        
        //两个指针同时遍历，当前面指针到达尾结点时，头开始遍历的指针到达倒数第k个结点处
        pSecond = list
        while pFirst != nil {
            pFirst = pFirst?.next
            pSecond = pSecond?.next
        }
        return pSecond
    }
    
    /* 反转链表
       输入一个链表，反转链表后，输出新链表的表头
     1.reverseLinkedList()递归的方法实现
     2.iterateLinkedList()迭代的方法实现
     返回值：新链表的表头
    */
    func reverseLinkedList(list: LinkNode?) -> LinkNode? {
        //递归结束条件
        if list == nil || list?.next == nil {
            return list
        }
        //第一个结点转换为最后一个结点，然后执行对next的反转
        let next = list?.next
        list?.next = nil
        let newHead = reverseLinkedList(list: next)
        next?.next = list
        return newHead
    }
    func iterateLinkedList(list: LinkNode?) -> LinkNode? {
        var pReverseHead: LinkNode?
        var pNode = list
        //已反转的结点
        var pPrev: LinkNode?
        while pNode != nil {
            let next = pNode?.next
            //pNode为最后一个结点
            if next == nil {
                pReverseHead = pNode
            }
            //反转pNode结点
            pNode?.next = pPrev
            pPrev = pNode
            pNode = next
        }
        return pReverseHead
    }
    /* 合并两个排序的链表
     输入两个单调递增的链表，输出两个链表合成后的链表
     要保证输出的链表单调不减
     返回值: 合成的链表
    */
    func merge(list1: LinkNode?, list2: LinkNode?) -> LinkNode? {
        //其中一个链表为nil，返回另一个链表
        if list1 == nil {
            return list2
        }
        if list2 == nil {
            return list1
        }
        if list1!.data! <= list2!.data! {
            list1?.next = merge(list1: list1?.next, list2: list2)
            return list1
        }else {
            list2?.next = merge(list1: list1, list2: list2?.next)
            return list2
        }
    }
    
    /* 二叉搜索树与双向链表
       输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的双向链表
       要求：不能创建任何新的结点，只能调整树中结点指针的指向
       二叉搜索树的特点：根节点的值大于其左子树每个结点的值，小于其右子树每个结点的值
       特点：中序遍历后的二叉树结点刚好是排好序的
    返回值：排序后的双向链表
    */
    func convert(bst: TreeNode?) -> TreeNode? {
        if bst == nil {
            return nil
        }
        if bst?.left == nil && bst?.right == nil {
            return bst
        }
        
        var newBst = bst
        
        let _ = convert(bst: newBst?.left)
        var left = newBst?.left
        
        //根结点的左子树的最右结点为根结点的前驱结点
        //根结点为左子树的最右结点的后继结点
        if left != nil {
            while left?.right != nil {
                left = left?.right
            }
            newBst?.left = left
            left?.right = newBst
        }
        
        let _ = convert(bst: newBst?.right)
        //根结点的右子树的最左结点为根结点的后继结点
        //根结点为右子树的最左结点的前驱结点
        var right = newBst?.right
        if right != nil {
            while right?.left != nil {
                right = right?.left
            }
            newBst?.right = right
            right?.left = newBst
        }
        
        //寻找到头指针
        while newBst?.left != nil {
            newBst = newBst?.left
        }
        return newBst
    }
    /* 两个链表的第一个公共结点
     */
    func findFirstCommonNode(list1: LinkNode?, list2: LinkNode?) -> LinkNode? {
        var firstList = list1, secondList = list2
        while firstList != secondList {
            firstList = (firstList == nil) ? list2 : firstList?.next
            secondList = (secondList == nil) ? list1 : secondList?.next
            print("\(firstList?.data ?? -1) se: \(secondList?.data ?? -1)")
        }
        return firstList
    }
    
    /* 把字符串转换为整数
     字符串不是一个合法的数值，则返回0
     1.字符串为空--返回0
     2.正负号的处理--第一个字符才能为正负号
     3.除了正负号，字符都是数字
     4.整数值是否溢出
     返回值: 元组(String, Int),String---值的描述
     */
    func strToInt(str: String) -> (String, Int) {
        if str.isEmpty {
            return ("empty string", 0)
        }
        //是否负数
        var isNegative = false
        var ret = 0
        for char in str {
            //第一个字符为负号
            if str.firstIndex(of: char) == str.startIndex &&
               (char == "-" || char == "+") {
                isNegative = (char == "-") ? true : false
            }else {
                if char > "9" && char < "0" {
                    return ("no number character", 0)
                }
                ret = ret * 10 + Int(String(char))!
            }
        }
        ret = isNegative ? -ret : ret
        if ret > INT32_MAX || ret < -2147483648{
            return ("overflow number", 0)
        }
        return ("success number", ret)
    }
}
