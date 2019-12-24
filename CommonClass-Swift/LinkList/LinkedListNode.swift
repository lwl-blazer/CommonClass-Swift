//
//  LinkedList.swift
//  CommonClass-Swift
//
//  Created by luowailin on 2019/12/24.
//  Copyright © 2019 luowailin. All rights reserved.
//

import Foundation

final class LinkNode<T:Comparable>{
    var element:T
    var nextNode : LinkNode?
    var preNode : LinkNode?
    
    init(_ element: T, _ next:LinkNode?, _ pre:LinkNode?) {
        self.element = element
        self.nextNode = next
        self.preNode = pre
    }
}

protocol LinkListInterface {
    associatedtype T:Comparable
    
    func clear()
    func contains(_ element: T) ->Bool
    func get(_ index: Int) ->T
    func insert(_ index: Int, _ element:T)
    func add(_ index: Int, _ element:T)
    func remove(_ index: Int) -> T
    func indexOf(_ element: T) ->Int
}

struct LinkListError : Error {
    var index:Int
    var size: Int
    var localizedDescription: String{
        return "out of bounds index:\(index) size:\(size)"
    }
}


class AbstractList<T:Comparable> {
    /**元素的数量*/
    public func getSize()->Int{
        return size
    }
    
    /**是否为空*/
    public func isEmpty()->Bool{
        return size == 0
    }
    
    /**添加元素到尾部*/
    public func add(_ element:T){
        
    }
    
    internal let ELEMENT_NOT_FOUND = -1
    internal var size: Int = 0
    internal var headNode:LinkNode<T>?
    internal var lastNode:LinkNode<T>?
    
    internal func rangeCheck(_ index:Int) throws{
        if index < 0 || index >= self.size {
            throw LinkListError.init(index: index, size: self.size)
        }
    }
    
    internal func rangeCheckForAdd(_ index:Int) throws{
        if index < 0 || index > self.size{
           throw LinkListError.init(index: index, size:self.size)
        }
    }
}


