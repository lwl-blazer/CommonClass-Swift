//
//  SingleLinkList.swift
//  CommonClass-Swift
//
//  Created by luowailin on 2019/12/24.
//  Copyright © 2019 luowailin. All rights reserved.
//

import Foundation

final class LinkedList<T:Comparable>: AbstractList<T>, LinkListInterface {
    override func add(_ element: T) {
        add(size, element)
    }
}

extension LinkedList{
    func clear() {
        if !isEmpty() {
            var node = self.headNode!
            var tmp = node.nextNode
            for _ in 0..<size {
                node.preNode = nil
                node.nextNode = nil
                if tmp == nil {
                    break
                }
                node = tmp!
                tmp = tmp!.nextNode
            }
        }
        
        size = 0
        headNode = nil
        lastNode = nil
    }
    
    func contains(_ element: T) -> Bool {
        return false
    }
    
    func get(_ index: Int) -> T {
        do {
            try! rangeCheck(index)
        }
        return nodeWith(index: index).element
    }
    
    func insert(_ index: Int, _ element: T){
        do {
            try! rangeCheckForAdd(index)
        }
        
        if self.size == index {
            let newNode = LinkNode.init(element, nil, lastNode)
            if lastNode == nil { //空链表
                headNode = newNode
            } else {
                lastNode!.nextNode = newNode
                newNode.preNode = lastNode!
            }
            lastNode = newNode
        } else {
            let nextNode = nodeWith(index: index)
            let preNode = nextNode.preNode
            let newNode = LinkNode.init(element, nextNode, preNode)
            
            if preNode == nil {
                self.headNode = newNode
            } else {
                preNode!.nextNode = newNode
            }
            nextNode.preNode = newNode
        }
        size+=1
    }
    
    func add(_ index: Int, _ element: T) {
        do {
            try! rangeCheckForAdd(index)
        }
        insert(self.size, element)
    }
    
    func remove(_ index: Int) -> T {
        do {
            try! rangeCheck(index)
        }
        
        let node = nodeWith(index: index)
        if node.preNode != nil {
            node.preNode!.nextNode = node.nextNode
        } else {
            self.headNode = node.nextNode
        }
        
        if node.nextNode != nil {
            node.nextNode!.preNode = node.preNode
        } else {
            self.lastNode = node.preNode
        }
        size-=1
        return node.element
    }
    
    func indexOf(_ element: T) -> Int {
        guard headNode != nil else{
            return ELEMENT_NOT_FOUND
        }
        
        var index = 0
        var node = headNode
        while node != nil {
            if node!.element == element {
                return index
            }
            
            node = node!.nextNode
            index+=1
        }
        return ELEMENT_NOT_FOUND
    }
    
    private func nodeWith(index:Int) ->LinkNode<T>{
        var node:LinkNode<T>
        if index < (size>>1) { //从头部开始查
            node = self.headNode!
            for _ in 0..<index {
                node = node.nextNode!
            }
        } else {
            node = self.lastNode!
            for _ in (0...index).reversed() {
                node = node.preNode!
            }
        }
        return node
    }
}
