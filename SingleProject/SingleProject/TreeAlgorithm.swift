//
//  TreeAlgorithm.swift
//  SingleProject
//
//  Created by Alex on 2020/11/26.
//

import Foundation
//树节点
class TreeNode: Equatable {
    
    var value: Int!
    var left: TreeNode?
    var right: TreeNode?
    
    //conform to protocol Equatable
    static func ==(lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs.value == rhs.value
    }
}
//结点包含父节点指针
class TreePNode: TreeNode {
    var parent: TreePNode?
//    var value: Int!
//    var left: TreePNode?
//    var right: TreePNode?
    
//    //conform to protocol Equatable
//    static func ==(lhs: TreePNode, rhs: TreePNode) -> Bool {
//        lhs.value == rhs.value
//    }
}

class Algorithm {
    /*创建二叉搜索树
      二叉搜索树的特点：根节点的值大于其左子树每个结点的值，小于其右子树每个结点的值
    */
    func binarySearchTreeAddNode(bst: inout TreeNode?, nodeValue: Int) {
        if bst == nil {
            let node = TreeNode()
            node.value = nodeValue
            node.left = nil
            node.right = nil
            bst = node
        }else {
            var current = bst
            while current != nil {
                //右子树位置
                if current!.value <= nodeValue {
                    if current?.right == nil {
                        let node = TreeNode()
                        node.value = nodeValue
                        node.left = nil
                        node.right = nil
                        current?.right = node
                        break
                    }
                    current = current?.right
                }else {
                    if current?.left == nil {
                        let node = TreeNode()
                        node.value = nodeValue
                        node.left = nil
                        node.right = nil
                        current?.left = node
                        break
                    }
                    current = current?.left
                }
            }
        }
    }
    
    /* 根据数组创建二叉树
     i从0开始
     二叉树的i结点的左子树为2*i+1,右子树为2*i+2
     注意:数组必须补全满二叉树的个数
     */
    func contructBinaryTreeWithArray(array: [Int?], isP: Bool) -> TreeNode? {
        var nodeList: [TreeNode?] = Array()
        for value in array {
            if value == nil {
                nodeList.append(nil)
            }else {
                let node = isP ? TreePNode() : TreeNode()
                node.value = value
                nodeList.append(node)
            }
        }
        let count = nodeList.count/2
        for index in 0..<count {
            if nodeList[index] != nil {
                if nodeList[2*index+1] != nil {
                    nodeList[index]?.left = nodeList[2*index+1]
                    if nodeList[index] is TreePNode {
                        (nodeList[2*index+1] as! TreePNode).parent = (nodeList[index] as! TreePNode)
                    }
                     
                }
                if nodeList[2*index+2] != nil {
                    nodeList[index]?.right = nodeList[2*index+2]
                    if nodeList[index] is TreePNode {
                        (nodeList[2*index+2] as! TreePNode).parent = (nodeList[index] as! TreePNode)
                    }
                }
            }
        }
        return nodeList[0]
    }
    
    /* 后序遍历
    */
    func postOrder(tree: TreeNode?) -> [Int] {
        if tree == nil {
            return []
        }
        var order: [Int] = Array()
        func postOrder(tr: TreeNode?) {
            if tr == nil {
                return
            }
            postOrder(tr: tr?.left)
            postOrder(tr: tr?.right)
            order.append(tr!.value!)
        }
        postOrder(tr: tree)
        return order
    }
    
    /* 根据结点值，找到对应结点
     */
    func findNode<T: TreeNode>(tree: T?, k: Int) -> T? {
        if tree == nil {
            return nil
        }
        print("tree:\(tree!.value!),k:\(k)")
        if tree!.value == k {
            return tree
        }
        var node: T?
        if tree!.left != nil {
            node = findNode(tree: tree!.left, k: k) as? T
            if node != nil {
                return node
            }
        }
        if tree!.right != nil {
            node = findNode(tree: tree!.right, k: k) as? T
            if node != nil {
                return node
            }
        }
        return nil
    }
    
    /* 重建二叉树
     输入某二叉树的中序遍历和前序遍历，重建二叉树
     1.前序遍历的首个结点是根节点
     2.根节点在中序遍历中，刚好分成左右子树
     返回值:树的根节点
    */
    func reContructBinaryTree(pre: [Int], tin: [Int]) -> TreeNode? {
        print("pre:\(pre), tin:\(tin)")
        if pre.isEmpty || tin.isEmpty {
            return nil
        }
        //前序遍历和中序遍历的数值不相同
        if Set.init(pre) != Set.init(tin) {
            return nil
        }
        let root = TreeNode()
        root.value = pre[0]
        root.left = nil
        root.right = nil
        
        let index = tin.firstIndex(of: pre[0])!
        //防止越界
        if index >= 1 {
            root.left = reContructBinaryTree(pre: Array.init(pre[1...index]), tin: Array.init(tin[...(index-1)]))
        }
        
        root.right = reContructBinaryTree(pre: Array.init(pre[(index+1)...]), tin: Array.init(tin[(index+1)...]))
        
        return root
    }
    
    /* 二叉树的下一个结点
     给定一个二叉树和其中一个结点，找出中序遍历顺序的下一个结点并且返回
     1.如果当前结点有右子树，则结点的下一个结点是右子树的最左结点
     2.否则，向上找第一个左链接指向的树包含该结点的祖先结点
     参考: https://blog.csdn.net/qq_29477893/article/details/107084595
     */
    func nextNodeOfK(tree: TreePNode?, k: Int) -> TreePNode? {
        if tree == nil {
            return nil
        }
        //找到值对应的结点
        var node = findNode(tree: tree, k: k)  //返回值为泛型
        if node == nil {
            return nil
        }
        if node?.right != nil {
            var sNode = node?.right
            while sNode?.left != nil {
                sNode = sNode?.left
            }
            return (sNode as? TreePNode)
        }else {
            var pNode = node?.parent
            while pNode != nil {
                if pNode?.left == node {
                    return pNode
                }
                let temp = pNode?.parent
                node = pNode
                pNode = temp
            }
        }
        return nil
    }
    
    /* 对称的二叉树
     参考: https://www.cnblogs.com/lishanlei/p/10707648.html
    */
    func isSymmetrical(tree: TreeNode?) -> Bool {
        if tree == nil {
            return true
        }
        return isSymmetrical(tree1: tree?.left, tree2: tree?.right)
    }
    
    private func isSymmetrical(tree1: TreeNode?, tree2: TreeNode?) -> Bool {
        if tree1 == nil && tree2 == nil {
            return true
        }else if tree1 == nil || tree2 == nil {
            return false
        }
        if tree1?.value != tree2?.value {
            return false
        }
        return isSymmetrical(tree1: tree1?.left, tree2: tree2?.right) &&
            isSymmetrical(tree1: tree1?.right, tree2: tree2?.left)
    }
    
    /* 按之字形顺序打印二叉树
     */
    func printZigzag(tree: TreeNode?) -> [[Int]] {
        if tree == nil {
            return []
        }
        //打印结果
        var result: [[Int]] = Array()
        //当前要打印的结点
        var nodes = [tree]
        var isRight = true
        while !nodes.isEmpty {
            var curNodes: [Int] = Array()
            var nextNodes: [TreeNode] = Array()
            if isRight {
                for node in nodes {
                    curNodes.append(node!.value)
                    //下一行从右到左
                    if node?.left != nil {
                        nextNodes.append(node!.left!)
                    }
                    if node?.right != nil {
                        nextNodes.append(node!.right!)
                    }
                }
            }else {
                for node in nodes {
                    curNodes.append(node!.value)
                    //下一行从左到右
                    if node?.right != nil {
                        nextNodes.append(node!.right!)
                    }
                    if node?.left != nil {
                        nextNodes.append(node!.left!)
                    }
                }
            }
            result.append(curNodes)
            nodes = nextNodes.reversed()
            isRight = !isRight
        }
        return result
    }
    
    /* 把二叉树打印成多行*/
    func printMultiLine(tree: TreeNode?) -> [[Int]] {
        if tree == nil {
            return []
        }
        var result: [[Int]] = Array()
        var nodes = [tree]
        while !nodes.isEmpty {
            var curNodes: [Int] = Array()
            var nextNodes: [TreeNode] = Array()
            for node in nodes {
                curNodes.append(node!.value!)
                //下一组结点
                if node?.left != nil {
                    nextNodes.append(node!.left!)
                }
                if node?.right != nil {
                    nextNodes.append(node!.right!)
                }
            }
            result.append(curNodes)
            nodes = nextNodes
        }
        return result
    }
    
    /* 序列化二叉树*/
    func serialize(tree: TreeNode?) -> String {
        if tree == nil {
            return "$"
        }
        return "\(tree!.value!)" + "," + serialize(tree: tree?.left) + "," + serialize(tree: tree?.right)
    }
    
    /* 反序列化二叉树*/
    func deserialize(str: String?) -> TreeNode? {
        var deserialzeStr = str
        func deserialize() -> TreeNode? {
            if deserialzeStr == nil || deserialzeStr!.isEmpty {
                return nil
            }
            let index = deserialzeStr?.firstIndex(of: ",")
            let node = index == nil ? deserialzeStr : String(deserialzeStr!.prefix(upTo: index!))
            deserialzeStr = index == nil ? nil : String(deserialzeStr!.suffix(from: deserialzeStr!.index(after: index!)))
            
            var root: TreeNode? = nil
            if node != "$" {
                let nodeValue = Int(node!)
                root = TreeNode()
                root?.value = nodeValue
                
                root?.left = deserialize()
                root?.right = deserialize()
            }
            return root
        }
        return deserialize()
    }
    
    /* 二叉搜索树的第k个结点
     二叉搜索树的中序遍历刚好排好序
     */
    func kthNode(tree: TreeNode?, k: Int) -> Int? {
        if tree == nil {
            return nil
        }
        var result: [Int] = Array()
        
        func inOrder(_ node: TreeNode?) {
            if node == nil || result.count > k-1 {
                return
            }
            inOrder(node?.left)
            result.append(node!.value!)
            inOrder(node?.right)
        }
        inOrder(tree)
        if result.count < k {
            return nil
        }
        return result[k-1]
    }
    
    /* 树的子结构
     输入两棵二叉树A,B,判断B是不是A的子结构
     tree2是不是tree1的子结构
     1.两棵树的根结点相等，则比较两个数左右子树的结点是否分别相等
     2.两个树的根结点不相等
      2.1 tree1的左子树是否包含tree2
      2.2 tree1的右子树是否包含tree2
     ps:约定空树不是任意一个树的子结构
    */
    func hasSubtree(tree1: TreeNode?, tree2: TreeNode?) -> Bool {
        var result = false
        if tree1 != nil && tree2 != nil {
            if tree1!.value! == tree2!.value! {
                result = doesTree1HaveTree2(tree1: tree1, tree2: tree2)
            }
            if !result {
                result = hasSubtree(tree1: tree1?.left, tree2: tree2)
            }
            if !result {
                result = hasSubtree(tree1: tree1?.right, tree2: tree2)
            }
        }
        return result
    }
    
    private func doesTree1HaveTree2(tree1: TreeNode?, tree2: TreeNode?) -> Bool {
        if tree1 == nil {
            return false
        }
        if tree2 == nil {
            return true
        }
        if tree1!.value! != tree2!.value! {
            return false
        }
        return doesTree1HaveTree2(tree1: tree1?.left, tree2: tree2?.left) && doesTree1HaveTree2(tree1: tree1?.right, tree2: tree2?.right)
    }
    
    /* 从上往下打印二叉树--层次遍历
     */
    func printFromTopToBottom(tree: TreeNode?) {
        if tree == nil {
            print("empty tree")
        }
        print("start print from top to bottom")
        var queue = [tree]
        while !queue.isEmpty {
            let currentNode = queue[0]
            queue.removeFirst()
            print("\(currentNode!.value!)", separator: "", terminator: ", ")
            if currentNode?.left != nil {
                queue.append(currentNode!.left)
            }
            if currentNode?.right != nil {
                queue.append(currentNode!.right)
            }
        }
        print("\n")
    }
    
    /* 二叉搜索树的后序遍历序列
     输入一个整数数组，判断该数组是不是某二叉搜索树的后续遍历结果
     1.后序遍历，最后一个时根结点
     2.二叉搜索树，根结点大于左子树，小于右子树
    */
    func isPostOrderOfBST(order: [Int]) -> Bool {
        if order.isEmpty {
            return false
        }
        //根结点值
        let rootValue = order[order.endIndex-1]
        //左子树结点结束位置
        var leftIndex = -1
        for index in 0..<(order.endIndex - 1) {
            if order[index] <= rootValue {
                leftIndex = index
            }else {
                break
            }
        }
        //检查右子树结点
        if (leftIndex+1) <= (order.endIndex - 1) {
            for index in (leftIndex+1)..<(order.endIndex-1) {
                if order[index] < rootValue {
                    return false
                }
            }
        }
        var left = true
        if leftIndex >= 0 {
            left = isPostOrderOfBST(order: Array(order[0...leftIndex]))
        }
        var right = true
        if (leftIndex+1) < (order.endIndex-1) {
            right = isPostOrderOfBST(order: Array(order[(leftIndex+1)..<(order.endIndex-1)]))
        }
        return left && right
    }
    
    /* 二叉树中和为某一值的路径
    */
    func findSumPath(tree: TreeNode?, sum: Int) -> [[Int]] {
        if tree == nil || tree!.value > sum {
            return []
        }
        var newSum = sum
        if tree?.left == nil && tree?.right == nil && tree?.value == sum {
            return [[tree!.value]]
        }else {
            newSum -= tree!.value
            let left = findSumPath(tree: tree?.left, sum: newSum)
            let right = findSumPath(tree: tree?.right, sum: newSum)
            var res: [[Int]] = Array()
            for value in left {
                res.append([tree!.value] + value)
            }
            for value in right {
                res.append([tree!.value] + value)
            }
            return res
        }
    }
    
    /* 二叉搜索树与双向链表
      输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的双向链表
      要求: 不能创建任何新的结点，只能调整树中结点指针的指向
      文件LinkedListAlgorithm中
      func convert(bst: TreeNode?) -> TreeNode?
      方法
    */
    
    /* 二叉树的深度
     DFS--深度优先搜索
     BFS--广度优先搜索
     */
    func treeDepth(tree: TreeNode?) -> Int {
        if tree == nil {
            return 0
        }
        return max(treeDepth(tree: tree?.left), treeDepth(tree: tree?.right)) + 1
    }
    func treeBreath(tree: TreeNode?) -> Int {
        if tree == nil {
            return 0
        }
        var depth = 0
        var queue = [tree]
        while !queue.isEmpty {
            for node in queue {
                queue.removeFirst()
                if node?.left != nil {
                    queue.append(node?.left)
                }
                if node?.right != nil {
                    queue.append(node?.right)
                }
            }
            depth += 1
        }
        return depth
    }
    
    /* 平衡二叉树
     特点:平衡二叉树左右子树高度差不超过1
     */
    func isBalanceTree(tree: TreeNode?) ->Bool {
        var isBalance = true
        
        func height(tree: TreeNode?) ->Int {
            if tree == nil || !isBalance {
                return 0
            }
            let left = height(tree: tree?.left)
            let right = height(tree: tree?.right)
            if abs(right-left) > 1 {
                isBalance = false
            }
            return 1+max(left, right)
        }
        let _ = height(tree: tree)
        return isBalance
    }
}

/* 数据流中的中位数
 堆: 1.每个结点的值总是不大于或不小于其父结点的值
 最小堆: 根结点最小的堆
 最大堆: 根结点最大的堆
*/
class Median {
    var left: [Int] = Array()
    var right: [Int] = Array()
    var count: Int = 0
    
    func insert(num: Int) {
        if count & 1 == 0 {  //偶数
            left.append(num)
        }else {
            right.append(num)
        }
        count += 1
    }
    
    func getMedian() -> Double {
        if count == 1 {
            return Double(left[0])
        }
        max_heap()
        min_heap()
        if left[0] > right[0] {
            let temp = left[0]
            left[0] = right[0]
            right[0] = temp
        }
        max_heap()
        min_heap()
        if count & 1 == 0 {
            return (Double(left[0]) + Double(right[0])) / 2.0
        }else {
            return Double(left[0])
        }
    }
    
    func max_heap() {
        //endIndex比最后元素的下标大1，如[1, 2]的endIndex为2,刚好为元素个数
        if left.endIndex > left.startIndex + 1 {
            for i in stride(from: left.endIndex/2-1, to: -1, by: -1) {
                var k = i
                let temp = left[k] //当前值，若不符合大顶堆，调整当前值
                while 2*k < left.endIndex-1 {
                    var index = 2*k+1  //i结点的左子结点序号
                    if index < left.endIndex - 1 {
                        //i根结点的左子结点符合大顶堆,考虑右子结点
                        if left[index] < left[index + 1] {
                            index += 1
                        }
                    }
                    //index为i结点左右结点中最大的结点序号
                    if temp >= left[index] {
                        break  //退出while循环，无需调整
                    }else {//完成i结点的调整，交换i结点和左右结点中最大值
                        left[k] = left[index]
                        k = index
                    }
                }
                left[k] = temp
            }
        }
    }
    
    func min_heap() {
        //right的元素个数大于1
        if right.endIndex > right.startIndex + 1 {
            for i in stride(from: right.endIndex/2-1, to: -1, by: -1) {
                var k = i
                let temp = right[k]
                while 2*k < right.endIndex - 1 {
                    var index = 2*k+1 //i结点对应的左结点
                    if index < right.endIndex - 1 {
                        //i结点对应的右结点比左结点小
                        if right[index] > right[index+1] {
                            index += 1  //右结点序号
                        }
                    }
                    
                    //i根结点小于左右子结点，无需调整
                    if temp < right[index] {
                        break
                    }else {
                        right[k] = right[index]
                        k = index
                    }
                }
                right[k] = temp
            }
        }
    }
}
