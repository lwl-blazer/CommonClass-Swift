//
//  protocol.swift
//  CommonClass-Swift
//
//  Created by luowailin on 2020/3/17.
//  Copyright © 2020 luowailin. All rights reserved.
//

import Foundation
import UIKit

/**
 * 协议提供特定名称和类型的实例属性或类型属性
 * 协议不指定属性是存储属性还是计算属性，只指定属性的名称和类型
 * 可以指定可读或可读可写
 * 协议属性的使用
 */
protocol SomeProtocol {
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int {get}
}

protocol FullyNamed {
    var fullName: String{get}
}

struct Person: FullyNamed {
    var fullName: String
}
//var john = Person(fullName: "John Appleseed")



class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String { //只读属性
        return (prefix != nil ? prefix! + "" : "") + name
    }
}
var ncc1701 = Starship(name: "enterprise", prefix: "USS")


/**
 * 协议方法
 *
 */
protocol RandomNumberGengerator {
    func random() ->Double
}

//线性同余生成器的伪随机数算法
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0;
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random()->Double{
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

/**异变方法要求 在值类型(结构体和枚举)的实例方法中， mutating 表示可以在该方法中修改它所属的实例以及实例的任意属性的值。 如果是类，则不用写mutating*/
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable{
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

/**构造器
 * 协议可以要求遵循协议的类型实现指定的构造器
 * 可以指定可失败构器要求
 */

/**协议做为类型
 * 有时被称[存在类型] [存在着一个类型T,该类型遵循协议T]
 * 使用场景:
 *   作为函数、方法或构造器中的参数类型或返回值类型
 *   作为常量、变量或属性的类型
 *   作为数组、字典或其他容器中的元素类型
 */
class Dice {
    let sides: Int
    let generator: RandomNumberGengerator
    init(sides: Int, generator: RandomNumberGengerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int{
        return Int(generator.random() * Double(sides)) + 1
    }
}

/**协议 extension**/
protocol TextRepresentable {
    var textualDescription: String {get}
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

//有条件地遵循协议 where
extension Array: TextRepresentable where Element:TextRepresentable {
    var textualDescription: String{
        let itemsAsText = self.map{$0.textualDescription}
        return "[" + itemsAsText.joined(separator: ",") + "]"
    }
}

//在extension里声明采纳协议
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named\(name)"
    }
}
extension Hamster: TextRepresentable{}

//let simonTheHamster = Hamster(name: "Simon")
//let somethingTextRepresentable: TextRepresentable = simonTheHamster
//print(somethingTextRepresentable.textualDescription)


/**
 * 协议扩展
 * 协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现
 */
extension RandomNumberGengerator{
    func randomBool() ->Bool{
        return random() > 0.5
    }
}


extension UIViewController: RandomNumberGengerator{
    func random() -> Double {
        return 10.0
    }
}

protocol AOPProtocol {
    
}

extension AOPProtocol{
    func start() {
        print("start")
    }
    
    func end(){
        print("end")
    }
}

class RootViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}



