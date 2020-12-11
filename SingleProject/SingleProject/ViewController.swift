//
//  ViewController.swift
//  SingleProject
//
//  Created by Alex on 2020/11/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        test()
    }
    
    func test() {
        testArrayAlgorithm()
        testStringAlgorithm()
        testFindAlgorithm()
        testLinkedListAlgorithm()
        testTreeAlgorithm()
        testStackAlgorithm()
        testDPAlgorithm()
        testBacktrackingAlgorithm()
    }
    
    func testArrayAlgorithm() {
        //测试二位数组中查找指定值
        let array = [[1, 3, 6, 9, 10],
                     [2, 4, 7, 11, 13],
                     [5, 8, 14, 15, 17],
                     [18, 19, 21, 25, 35]
        ]
        let result = findValue(array: array, value: 21)
        print(result)
        //测试数组中重复的数字
        var ary = [1, 5, 4, 2, 5, 1]
        let dup = duplicate(array: &ary)
        print("duplicate: \(dup)")
        //测试乘积数组
        let aryM = [1, 5, 4, 2, 5, 1]
        let aryB = multiply(arrayA: aryM)
        print("multiply: \(aryB)")
        //测试调整数组顺序，使奇数在前偶数在后
        var aryO = [4, 3, 2, 5, 6, 8, 11, 7, 10, 9]
        reOrderArray(array: &aryO)
        print("reOrderArray: \(aryO)")
        
        //测试顺时针打印矩阵
        let aryP = [[1, 2, 3, 4],
                    [12,13,14,5],
                    [11,16,15,6],
                    [10,9, 8, 7,]
        ]
        let aryPP = printMatrix(array: aryP)
        print("printMatrix: \(aryPP)")
        
        //测试连续子数组最大值
        let aryS=[1,-1, 0, -3, 4, 5]
        let sum = findGreatestSumOfSubArray(array: aryS)
        print("findGreatestSumOfSubArray: \(sum)")
        
        //测试把数组排成最小的数
        var aryMin: [UInt] = [3, 32, 321]
        let minNumber = printMinNumber(array: &aryMin)
        print("printMinNumber: \(minNumber)")
    }
    
    //测试字符串算法
    func testStringAlgorithm() {
        //测试字符串替换空格
        let oneString = " 555String deeee"
        print("after replace string: \(replaceSpace(original: oneString))")
        
        //测试正则表达式
        let str = "aaa", pattern = "a*ac*a"
        var result = match(str: str, pattern: pattern)
        print("the match result: \(result)")
        
        //测试字符串是否为数值
        let strN = "233e-3."
        result = isNumeric(str: strN)
        print("the \(strN) is numeric: \(result)")
        
        //测试字符流中第一个不重复的字符
        let myStr = "ogoogle"
        var solution = Solution()
        for ch in myStr {
            solution.insert(char: ch)
            print("insert is: \(ch),first appear is:\(solution.firstAppearingOnce())")
            
        }
        
        //测试字符串的排列
        let strPerm = "cabb"
        let resultPerm = permutation(str: strPerm)
        print("the permutation string are: \(resultPerm)")
    }
    //测试查找算法
    func testFindAlgorithm() {
        //测试查找旋转数组中最小的元素
        let rotateAry = [2, 3, 4, 5, 6, 1]
        let minValue = minNumberInRotateArray(ary: rotateAry)
        print("the min value is: \(minValue)")
        
        //测试数字在排序数组中出现的次数
        let ary = [1, 2, 3, 3, 3, 3, 4, 6]
        let frequency = repeatTimesOfK(ary: ary, k: 4)
        print("the repeat of times is: \(frequency)")
    }
    
    //测试链表算法
    func testLinkedListAlgorithm() {
        //测试链表中增加尾结点
        let list = List()
        let datas = [2, 5, 12, 3, 6]
        var link:LinkNode?
        //给list赋值
        for data in datas {
            list.addListTill(linkedList: &link, data: data)
        }
        
        //测试从尾到头打印链表
        //list.printListFromTallToHead(list: link)
        
        //创建环链表
        list.createLoopLinkedList(list: link, k: 12)
        //测试链表中的入口结点
        let meetNode = list.entryNodeOfLoop(list: link)
        if meetNode != nil {
            print("the meetNode data is: \(meetNode!.data!))")
        }
        
        //测试删除链表中重复的结点
        let nodes = [2, 2, 2, 3, 5, 7, 9, 9, 10]
        var linkedNode: LinkNode?
        for nodeValue in nodes {
            list.addListTill(linkedList: &linkedNode, data: nodeValue)
        }
        var newLink = list.deleteDuplication(list: linkedNode)
        while newLink != nil {
            print("the node value: \(newLink?.data ?? -1)")
            newLink = newLink?.next
        }
        
        //测试链表中倒数第k个结点
        let kNodes = [1, 5, 12, 8, 5, 7, 19, 9, 10]
        var kList: LinkNode?
        for nodeValue in kNodes {
            list.addListTill(linkedList: &kList, data: nodeValue)
        }
        let kth = 1
        let kNode = list.findKthToTill(list: kList, k: kth)
        print("the \(kth) to till is: \(kNode?.data ?? -1)")
        
        //测试反转链表
        let nodeValues = [1, 5, 12, 8, 5, 7, 19, 9, 10]
        var rList: LinkNode?
        for nodeValue in nodeValues {
            list.addListTill(linkedList: &rList, data: nodeValue)
        }
        var rNode: LinkNode?
        let value = "reverse"
        switch value {
        case "reverse":
            rNode = list.reverseLinkedList(list: rList)
        case "iterate":
            rNode = list.iterateLinkedList(list: rList)
        default:
            rNode = nil
        }
        print("reverse linkedList:")
        printLinkedList(list: rNode)
        
        //测试合并两个排序的链表
        let list1Nodes = [1, 5, 7, 8, 9, 10]
        var list1: LinkNode?
        for nodeValue in list1Nodes {
            list.addListTill(linkedList: &list1, data: nodeValue)
        }
        
        let list2Nodes = [2, 4, 6, 11, 13, 15]
        var list2: LinkNode?
        for nodeValue in list2Nodes {
            list.addListTill(linkedList: &list2, data: nodeValue)
        }
        
        let mergeList1AndList2 = list.merge(list1: list1, list2: list2)
        print("after merge list1 and list2:")
        printLinkedList(list: mergeList1AndList2)
        
        //测试二叉搜索树与双向链表
        let bst = createBST()
        let doubleList = list.convert(bst: bst)
        print("doubleList:")
        printDoubleLinkedList(doubleList: doubleList)
        
        //测试两个链表的第一个公共结点
        let list11Nodes = [1, 5, 7, 6]
        var list11: LinkNode?
        for nodeValue in list11Nodes {
            list.addListTill(linkedList: &list11, data: nodeValue)
        }
        
        let common1 = LinkNode()
        common1.data = 8
        
        let common2 = LinkNode()
        common2.data = 10
        common1.next = common2
        common2.next = nil
        
        var temp = list11
        while temp != nil {
            if temp?.next == nil {
                temp?.next = common1
                break
            }
            temp = temp?.next
        }
        
        let list22Nodes = [2, 4, 3, 12, 15, 17]
        var list22: LinkNode?
        for nodeValue in list22Nodes {
            list.addListTill(linkedList: &list22, data: nodeValue)
        }
        temp = list22
        while temp != nil {
            if temp?.next == nil {
                temp?.next = common1
                break
            }
            temp = temp?.next
        }
        let nodeF = list.findFirstCommonNode(list1: list11, list2: list22)
        if nodeF != nil {
            print("the common node: \(nodeF!.data!)")
        }
        
        //测试把字符串转换为整数
        let val = "-32333322"
        let connect = list.strToInt(str: val)
        print("the \(val) string to int:\(connect.1), description: \(connect.0)")
        
    }
    
    //打印双向链表
    func printDoubleLinkedList(doubleList: TreeNode?) {
        var dbList = doubleList
        var lastNode = false
        while dbList != nil {
            if dbList?.right == nil {
                lastNode = true
            }
            print("[\(dbList!.value!)]", separator: " ", terminator: lastNode ? "\n" : "<=>")
            dbList = dbList?.right
        }
    }
    //打印链表
    func printLinkedList(list: LinkNode?) {
        var node = list
        while node != nil {
            print("\(node!.data!)", separator: " ", terminator: " ")
            node = node?.next
        }
        print("", separator: "", terminator: "\n")
    }
    
    //测试树算法
    func testTreeAlgorithm() {
        //测试创建二叉搜索树
        print("create BST start:")
        let bst = createBST()
        printBinaryTree(binaryTree: bst, spaceCount: 20)
        
        
        let algorithm = Algorithm()
        
        //测试重建二叉树
        let pre = [1, 2, 4, 7, 3, 5, 6, 8]
        let tin = [4, 7, 2, 1, 5, 3, 8, 6]
        let newBT = algorithm.reContructBinaryTree(pre: pre, tin: tin)
        print("print the recontruct binary tree:")
        printBinaryTree(binaryTree: newBT, spaceCount: 20)
        
        //测试根据数组创建二叉树
        let ary = [3, 5, 8, 9, 10, nil, 13, nil, nil, 18, nil, nil, nil]
        let tree = algorithm.contructBinaryTreeWithArray(array: ary, isP: true)
    
        //测试二叉树的下一个结点
        let node = algorithm.nextNodeOfK(tree: tree as? TreePNode, k: 13)
        if node != nil {
            print("print binary tree next node:\(node!.value!)")
        }else {
            print("current node no next node")
        }
        
        //测试对称二叉树
        let syNodes = [8, 8, 8, 8, 8, 8, nil];
        let syTree = algorithm.contructBinaryTreeWithArray(array: syNodes, isP: false)
        let result = algorithm.isSymmetrical(tree: syTree)
        print("it is a symmetrical binary tree: \(result)")
        
        //测试按之字形打印二叉树
        let nodes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
        let bt = algorithm.contructBinaryTreeWithArray(array: nodes, isP: false)
        let zigzag = algorithm.printZigzag(tree: bt)
        print("zigzag nodes:")
        for item in zigzag {
            print(item)
        }
        
        //测试把二叉树打印成多行
        let multiLine = algorithm.printMultiLine(tree: bt)
        print("multi-line nodes:")
        for item in multiLine {
            print(item)
        }
        
        //测试序列化二叉树
        print("before serialize binary tree:")
        printBinaryTree(binaryTree: bt, spaceCount: 20)
        let re = algorithm.serialize(tree: bt)
        print("serialize binary tree:\(re)")
        
        //测试反序列化二叉树
        let root = algorithm.deserialize(str: re)
        print("deserialize binary tree:")
        printBinaryTree(binaryTree: root, spaceCount: 20)
        
        //测试二叉搜索树的第k个结点值
        print("test kth node value begin:")
        printBinaryTree(binaryTree: bst, spaceCount: 20)
        let value = algorithm.kthNode(tree: bst, k: 6)
        print("kth node value:\(value ?? -1)")
        
        //测试数据流中的中位数
        let values = [10, 6, 4, 7, 5]
        let medianObj = Median()
        for value in values {
            medianObj.insert(num: value)
            let median = medianObj.getMedian()
            print("the median value:\(median)")
        }
        
        //测试树的子结构
        let tree1Nodes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
        let tree1 = algorithm.contructBinaryTreeWithArray(array: tree1Nodes, isP: false)
        let tree2Nodes = [1, 2, 6, 4, 5]
        let tree2 = algorithm.contructBinaryTreeWithArray(array: tree2Nodes, isP: false)
        let result1 = algorithm.hasSubtree(tree1: tree1, tree2: tree2)
        print("has subtree:\(result1)")
        
        //测试从上往下打印二叉树
        algorithm.printFromTopToBottom(tree: tree1)
        
        //测试二叉搜索树的后序遍历序列
        let nodeValues: [Int] = [1, 6, 4, 3, 5, 9, 10]
        var trBST: TreeNode?
        for value in nodeValues {
            algorithm.binarySearchTreeAddNode(bst: &trBST, nodeValue: value)
        }
        print("is post order of BST start")
        printBinaryTree(binaryTree: trBST, spaceCount: 20)
        let order = algorithm.postOrder(tree: trBST)
        print("order:\(order)")
        let isPostOrder = algorithm.isPostOrderOfBST(order: order)
        print("is post order of BST:\(isPostOrder)")
        
        //测试二叉树中和为某一值的路径
        let sNodes = [50, 45, 40, 20, 25, 35, 30, 5, 15]
        let tr11 = algorithm.contructBinaryTreeWithArray(array: sNodes, isP: false)
        let path = algorithm.findSumPath(tree: tr11, sum: 120)
        print("find sum path: \(path)")
        
        //测试二叉树的深度
        let depth = algorithm.treeBreath(tree: tr11)
        print("tree depth:\(depth)")
        
        //测试平衡二叉树
        let isBalance = algorithm.isBalanceTree(tree:trBST)
        print("is balance tree:\(isBalance)")
    }
    
    //测试栈算法
    func testStackAlgorithm() {
        //测试用两个栈实现队列
        let queue = queueWithTwoStack()
        queue.push(node: 10)
        queue.push(node: 20)
        print("queue with two stack:\(queue.pop()!)")
        
        var stack = [10]
        stack.append(10)
        print("stack:\(stack)")
        
        //测试包含min函数的栈
        let minStack = includeMinStack()
        minStack.push(node: 10)
        minStack.push(node: 20)
        minStack.push(node: 30)
        minStack.push(node: 5)
        minStack.push(node: 10)
        minStack.pop()
        minStack.pop()
        minStack.pop()
        minStack.pop()
        minStack.pop()
        minStack.pop()
        minStack.push(node: 10)
        minStack.push(node: 20)
        print("the min value:\(minStack.min() ?? -1)")
        
        //测试栈的压入、弹出序列
        let pushV = [1, 2, 3, 4, 5]
        var popV = [4, 3, 5, 1, 2]
        let isOrder = isPopOrder(pushV: pushV, popV: &popV)
        print("is pop order:\(isOrder)")
    
    }
    
    //测试动态规划
    func testDPAlgorithm() {
        //测试字符串匹配
        let isMatch = matchStrWithPattern(str: "aaa", pattern: "ab*a")
        print("match string with pattern:\(isMatch)")
        
        //测试斐波那契数列
        let result = fabonacci(n: 20)
        print("fabonacci: \(result)")
        
        //测试跳台阶
        let re = jumpSteps(n: 7)
        print("jump steps: \(re)")
        
        //测试变态跳台阶
        let sum = DPAndRecursion().jumpStepsII(n: 5)
        print("jump steps II: \(sum)")
        
        //测试矩形覆盖
        let theSum = DPAndRecursion().rectCover(n: 7)
        print("rect cover: \(theSum)")
        
        //测试二进制中1的个数
        let total = binaryNumberOf1(n: -1)
        print("binary number of 1: \(total)")
        
        //测试丑数
        let bigestUglyNumber = uglyNumber(n: 9)
        print("bigest ugly number:\(bigestUglyNumber)")
    }
    
    //测试回溯法
    func testBacktrackingAlgorithm() {
        //测试矩阵中的路径
        let matrix = [["a", "b", "c", "e"],
                      ["s", "f", "c", "s"],
                      ["a", "d", "e", "e"]]
        let str = "abcb"
        let result = MatrixPath().hasPath(matrix: matrix, str: str)
        print("matrix has path: \(result)")
    }
    
    //createBST
    func createBST() -> TreeNode? {
        let nodeValues = [1, 6, 4, 3, 5, 9, 10]
        var tree: TreeNode?
        let algorithm = Algorithm()
        for value in nodeValues {
            algorithm.binarySearchTreeAddNode(bst: &tree, nodeValue: value)
        }
        return tree
    }
    
    
    
    //打印二叉树
    func printBinaryTree(binaryTree: TreeNode?, spaceCount: Int) {
        if binaryTree == nil {
            print("empty tree")
            return
        }
        var nodes = [(spaceCount, binaryTree)]
        while !nodes.isEmpty {
            var nextNodes: [(Int, TreeNode)] = Array()
            var nodeCount = 0
            var slash = String()
            for tuple in nodes {
                print(spaceString(tuple.0 - nodeCount) + "\(tuple.1!.value!)", separator: "", terminator: "")
                if tuple.1?.left != nil && tuple.1?.right != nil {
                    slash += spaceString(tuple.0 - nodeCount - 2) + "/    \\"
                    nextNodes.append((tuple.0-3, tuple.1!.left!))
                    nextNodes.append((tuple.0+3, tuple.1!.right!))
                }else if tuple.1?.left != nil {
                    slash += spaceString(tuple.0 - nodeCount - 2) + "/"
                    nextNodes.append((tuple.0-3, tuple.1!.left!))
                }else if tuple.1?.right != nil {
                    slash += spaceString(tuple.0 - nodeCount + 2) + "\\"
                    nextNodes.append((tuple.0+3, tuple.1!.right!))
                }
                nodeCount = tuple.0
            }
            print("\n" + slash)
            nodes = nextNodes
        }
    }
    
    func spaceString(_ spaceCount: Int) -> String {
        var spaceStr = ""
        if spaceCount >= 1 {
            for _ in 1...spaceCount {
                spaceStr += " "
            }
        }
        return spaceStr
    }
}

