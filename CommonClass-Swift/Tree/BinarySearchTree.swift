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
    var callBackClosure:((_ element : Element) -> Void)?;
    
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
        callBackClosure = closure
        self .preorderTraversal(root)
        callBackClosure = nil
    }
    
    func inorderTraversalUsingBlock(_ closure: @escaping (Element) -> Void) {
        guard (root != nil) else {
            return
        }
        callBackClosure = closure
        self.inorderTraversal(root)
        callBackClosure = nil
    }
    
    func postorderTraversalUsingBlock(_ closure: @escaping (Element) -> Void) {
        guard (root != nil) else {
            return
        }
        callBackClosure = closure
        self.postorderTraversal(root)
        callBackClosure = nil
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
