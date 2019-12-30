//
//  Tree.swift
//  CommonClass-Swift
//
//  Created by luowailin on 2019/12/11.
//  Copyright © 2019 luowailin. All rights reserved.
//

import Foundation
//节点
class TreeNode<T:Comparable>:Equatable{

    var element : T
    var left : TreeNode?
    var right : TreeNode?
    var parent : TreeNode?
    
    init(_ element : T, _ parent: TreeNode?) {
        self.element = element
        self.parent = parent
    }
    
    /**
     * 是否为叶子节点
     */
    public func isLeafNode() ->Bool{
        if left == nil && right == nil {
            return true
        }
        return false
    }
    
    /**
     *是否度为2
     */
    public func hasTwoChildren() ->Bool{
        if left != nil && right != nil {
            return true
        }
        return false
    }

    static func == (lhs: TreeNode<T>, rhs: TreeNode<T>) -> Bool {
        return lhs.element == rhs.element
    }
}

//二叉树-父类
class BinaryTree<T:Comparable> {
    var root : TreeNode<T>?
    var size : Int
    
    init() {
        size = 0
    }
    
    public func isEmpty()->Bool{
        return size == 0
    }
    
    public func clear(){
        
    }
    
    public func add(_ element:T){
    }
    
    public func treeHeight() ->Int{
        return 0;
    }
    
    public func remove(element :T) ->Void{
        
    }
    
    /**
     * 层序遍历
     * 计算二叉树的高度
     * 判断一棵树是否为完全二叉树
     */
    func levelOrderTraversalUsingBlock(_ closure:(_ element:T)->Void){
        
    }
    
    /**
     * 前序遍历 先根节点(再左子树再右子树)
     */
    func preorderTraversalUsingBlock(_ closure: @escaping (_ element:T)->Void){
        
    }
    
    /**
     * 中序遍历 先左子树 再根节点 再右子树
     *
     */
    func inorderTraversalUsingBlock(_ closure: @escaping (_ element:T)->Void){
        
    }
    
    /**
     * 后序遍历 先左子树 再右子树 后根节点
     * 适用于一些先子后父的操作
     */
    func postorderTraversalUsingBlock(_ closure: @escaping (_ element:T)->Void){
        
    }
    
    internal func predecessor(node:TreeNode<T>) ->TreeNode<T>?{
        return nil;
    }
    
    internal func successor(node:TreeNode<T>) ->TreeNode<T>?{
        return nil;
    }
}
