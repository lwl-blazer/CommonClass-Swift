//
//  Queue.swift
//  CommonClass-Swift
//
//  Created by luowailin on 2019/12/11.
//  Copyright © 2019 luowailin. All rights reserved.
//

import Foundation

/** 队列 */
struct Queue<T> {
    fileprivate var array = [T?]()
    fileprivate var head = 0;
    
    public var isEmpty:Bool{
        return (array.count - head == 0)
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequene() -> T?{
        guard head < array.count , let element = array[head] else {
            return nil;
        }
        
        array[head] = nil;
        head += 1;
        
        let percentage = Double(head) / Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}

/** mutating
* 用法:
* 1.结构体、枚举类型的方法声明
* 2.extension中的方法声明
* 3.protocol方法声明
*
* 修改struct,enum的属性变量 swift中struct和enum中可以包含类方法和实例方法，可是官方不建议在实例方法中修改其属性变量，在func前加入mutating关键字后，使其属性变量可修改(mutable）
*/
