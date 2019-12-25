//
//  BinarySearchTree.swift
//  CommonClass-Swift
//
//  Created by luowailin on 2019/12/11.
//  Copyright © 2019 luowailin. All rights reserved.
//

import UIKit

/**
 * 二叉搜索树
 */
class BinarySearchTree<Element:Comparable>:TreeObjectDelegate{
    
    typealias T = Element
    var root: TreeNode<Element>?
    var size: Int
    var callBackClosure:((_ element : Element) -> Void)?
    
    init() {
        size = 0
    }
    
    public func isEmpty()->Bool{
        return size == 0
    }
    
    public func clear(){
        
    }
    
    public func add(_ element:Element){
        if root == nil {
            root = TreeNode.init(element, nil)
            size+=1
            return
        }
        
        var node = root;
        var parent = root!;
        var result = ComparisonResult.orderedAscending
        while node != nil {
            parent = node!
            result = self.compareTo(element, node!.element)
            switch result {
            case .orderedAscending:
                node = node!.left
                break
            case .orderedDescending:
                node = node!.right
                break
            default:
                node!.element = element;
                return
            }
        }
        
        let newNode = TreeNode.init(element, parent)
        if result == .orderedDescending {
            parent.right = newNode
        } else {
            parent.left = newNode
        }
        size += 1
    }
    
    /**树的高度*/
    public func treeHeight() ->Int{
        //return self.treeHeightRecursion(root)
        return self.treeHeightCicre()
    }
    
    /**判断是否为完全二叉树*/
    public func isCompleteTree() ->Bool{
        guard (root != nil) else {
            return false
        }
        
        var queue : Queue<TreeNode<Element>> = Queue.init()
        queue.enqueue(root!)
        var isleaver = false
        while !queue.isEmpty {
            let node = queue.dequene()
            guard (node != nil) else {
                return false
            }
            
            if isleaver {
                if node!.left != nil || node!.right != nil {
                    return false
                }
            } else {
                if node!.left != nil && node!.right != nil {
                    queue.enqueue(node!.left!)
                    queue.enqueue(node!.right!)
                } else if node!.left == nil && node!.right != nil {
                    return false
                } else { //叶子节点
                    if node!.left != nil {
                        queue.enqueue(node!.left!)
                    }
                    isleaver = true
                }
            }
        }
        return true
    }
    
    
    /** https://leetcode-cn.com/problems/invert-binary-tree/submissions/
     * leetcode 226. 翻转二叉树
     */
    public func invertTree(){
        //递归
        //self.invertTreeRecursion(root)
        self.invertTreeCicle(root)
    }
}

extension BinarySearchTree{
    func preorderTraversalUsingBlock(_ closure: @escaping (Element) -> Void) {
        guard (root != nil) else {
            return
        }
        /* 递归
        callBackClosure = closure
        self .preorderTraversal(root)
        callBackClosure = nil*/
        
        /**非递归*/
        /*var heap :[TreeNode<Element>] = Array.init()
        heap.append(root!)
        
        var node : TreeNode<Element>
        while heap.count > 0 {
            node = heap.removeLast()
            closure(node.element)
            if node.right != nil {
                heap.append(node.right!)
            }
            
            if node.left != nil {
                heap.append(node.left!)
            }
        }*/
        
        /**莫里斯 遍历
         * 就是利用线索二叉树
         * 线索二叉树，就是利用大量的空闲指针，利用这些空指针域来存放指向该节点的直接前驱或直接后继的指针，则可以进行某些更方便的运算。这些被重新利用起来的空指针就被称为线索，加上这些线索的二叉树就是线索二叉树
         *
         */
        var node = root
        while node != nil {
            if node!.left == nil {
                closure(node!.element)
                node = node!.right
            } else {
                var predecessor = node!.left!
                //找node的前驱节点  node.left != nil predecessor = node.left.right.right...
                while predecessor.right != nil && predecessor.right! !== node! { //predecessor.right! != node! 处理伪边
                    predecessor = predecessor.right!
                }
                
                if predecessor.right == nil { //伪边
                    closure(node!.element)
                    predecessor.right = node!
                    node = node!.left
                } else {
                    predecessor.right = nil
                    node = node!.right
                }
            }
        }
    }
    
    func inorderTraversalUsingBlock(_ closure: @escaping (Element) -> Void) {
        guard (root != nil) else {
            return
        }
        /* 递归
        callBackClosure = closure
        self.inorderTraversal(root)
        callBackClosure = nil
        */
        
        //利用莫里斯遍历-线索二叉树
        var node = root;
        var predecessor : TreeNode<Element>
        while node != nil {
            if node!.left == nil {
                closure(node!.element);
                node = node!.right
            } else {
                predecessor = node!.left!
                while predecessor.right != nil {
                    predecessor = predecessor.right!
                }
                
                predecessor.right = node
                
                //破坏左边 只保留右边
                let temp = node!
                node = node!.left
                temp.left = nil
            }
        }
    }
    
    func postorderTraversalUsingBlock(_ closure: @escaping (Element) -> Void) {
        guard (root != nil) else {
            return
        }
        /*
        callBackClosure = closure
        self.postorderTraversal(root)
        callBackClosure = nil*/
        
        /** 利用栈的特性， 后进先出的原则 */
        var queue :Array<TreeNode<Element>> = Array.init()
        var array :Array<TreeNode<Element>> = Array.init()
        var node : TreeNode<Element>
        queue.append(root!)
        while queue.count != 0 {
            node = queue.removeLast()
            array.insert(node, at: 0)
            
            if node.left != nil {
                queue.append(node.left!)
            }
            
            if node.right != nil {
                queue.append(node.right!)
            }
        }
        
        for node in array {
            closure(node.element)
        }
    }
    
    func levelOrderTraversalUsingBlock(_ closure:(_ element:T)->Void){
        guard (root != nil) else {
            return
        }
        var queue: Queue<TreeNode<T>> = Queue.init()
        queue.enqueue(root!)
        while !queue.isEmpty {
            let node = queue.dequene()
            guard (node != nil) else {
                break
            }
            
            closure(node!.element)
            
            if node!.left != nil {
                queue.enqueue(node!.left!)
            }
            
            if node!.right != nil {
                queue.enqueue(node!.right!)
            }
        }
    }
    
    private func preorderTraversal(_ node:TreeNode<Element>?){
        guard (node != nil) else {
            return
        }
        if callBackClosure != nil {
            callBackClosure!(node!.element)
        }
        
        self.preorderTraversal(node!.left)
        self.preorderTraversal(node!.right)
    }
    
    private func inorderTraversal(_ node: TreeNode<Element>?) {
        guard (node != nil) else {
            return
        }
        
        self.inorderTraversal(node!.left)
        if callBackClosure != nil {
            callBackClosure!(node!.element)
        }
        self.inorderTraversal(node!.right)
    }
    
    private func postorderTraversal(_ node: TreeNode<Element>?){
        guard (node != nil) else {
            return
        }
        
        self.preorderTraversal(node!.left)
        self.preorderTraversal(node!.right)
        if callBackClosure != nil {
            callBackClosure!(node!.element)
        }
    }
}

extension BinarySearchTree {
    private func compareTo(_ e1 :Element, _ e2 : Element) -> ComparisonResult {
        if e1 < e2 {
            return .orderedAscending
        }
        
        if e1 > e2 {
            return .orderedDescending
        }
        
        return .orderedSame
    }
    
    //递归计算
    private func treeHeightRecursion(_ node:TreeNode<Element>?) ->Int{
        if node == nil {
            return 0;
        }
        return 1 + max((self.treeHeightRecursion(node!.left)), (self.treeHeightRecursion(node!.right)));
    }
    
    //循环计算
    private func treeHeightCicre() -> Int{
        guard (root != nil) else {
            return 0
        }
        
        var height : Int = 0
        var level : Int = 0
        var queue : Queue<TreeNode<Element>> = Queue.init()
        queue.enqueue(root!)
        level = queue.count
        while !queue.isEmpty {
            let node = queue.dequene()
            guard (node != nil) else {
                break
            }
            
            if node!.left != nil {
                queue.enqueue(node!.left!)
            }
            
            if node!.right != nil {
                queue.enqueue(node!.right!)
            }
            
            level -= 1
            if level == 0 {
                height += 1
                level = queue.count
            }
        }
        return height
    }
    
    private func invertTreeRecursion(_ node:TreeNode<Element>?){
        guard node != nil else {
            return
        }
        
        let tmp = node!.left
        node!.left = node!.right
        node!.right = tmp
        
        self.invertTreeRecursion(node!.left)
        self.invertTreeRecursion(node!.right)
    }
    
    private func invertTreeCicle(_ root:TreeNode<Element>?){
        guard root != nil else {
            return
        }
        
        var queue : Queue<TreeNode<Element>> = Queue.init()
        queue.enqueue(root!)
        while !queue.isEmpty {
            
            let node = queue.dequene()
            guard node != nil else {
                break
            }
            
            let tmp = node!.left
            node!.left = node!.right
            node!.right = tmp
            
            if node!.left != nil {
                queue.enqueue(node!.left!)
            }
            if node!.right != nil {
                queue.enqueue(node!.right!)
            }
        }
    }
}

extension BinarySearchTree{
    /**找前驱节点:中序遍历时的前一个节点*/
    private func predecessor(node:TreeNode<Element>) ->TreeNode<Element>?{
        
        if node.left != nil { //node.left.right.right
            var tmp = node.left
            var predecessorNode = tmp
            while tmp != nil {
                predecessorNode = tmp!
                tmp = tmp!.right
            }
            return predecessorNode
        } else if node.parent != nil {
            var tmp = node.parent
            var p = node
            while tmp != nil {
                if tmp!.right === p {
                    return tmp!;
                }
                p = tmp!
                tmp = tmp!.parent
            }
        }
        return nil
    }
    
    /**找后继节点:中序遍历时的后一个节点*/
    private func successor(node:TreeNode<Element>) ->TreeNode<Element>?{
        if node.right != nil {
            var tmp = node.right
            var successorNode = tmp
            while tmp != nil {
                successorNode = tmp!
                tmp = tmp!.left
            }
            return successorNode!
        } else if node.parent != nil {
            var tmp = node.parent
            var p = node
            while tmp != nil {
                if tmp!.left === p {
                    return tmp!;
                }
                p = tmp!
                tmp = tmp!.parent
            }
        }
        return nil
    }
}
