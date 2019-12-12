//
//  Tree.swift
//  CommonClass-Swift
//
//  Created by luowailin on 2019/12/11.
//  Copyright © 2019 luowailin. All rights reserved.
//

import Foundation

class TreeNode<T:Comparable>{
    var element : T
    var left : TreeNode?
    var right : TreeNode?
    var parent : TreeNode?
    
    init(_ element : T, _ parent: TreeNode?) {
        self.element = element
        self.parent = parent
    }

}

protocol TreeObjectDelegate {
    associatedtype T:Comparable
    var root : TreeNode<T>?{get set}
    var size : Int{get}
    
    /**
     * 层序遍历
     * 计算二叉树的高度
     * 判断一棵树是否为完全二叉树
     */
    func levelOrderTraversalUsingBlock(_ closure:(_ element:T)->Void)
    
    /**
     * 前序遍历 先根节点(再左子树再右子树)
     */
    func preorderTraversalUsingBlock(_ closure: @escaping (_ element:T)->Void)
    
    /**
     * 中序遍历 先左子树 再根节点 再右子树
     *
     */
    func inorderTraversalUsingBlock(_ closure: @escaping (_ element:T)->Void)
    
    /**
     * 后序遍历 先左子树 再右子树 后根节点
     * 适用于一些先子后父的操作
     */
    func postorderTraversalUsingBlock(_ closure: @escaping (_ element:T)->Void)
}
