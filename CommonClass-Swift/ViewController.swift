//
//  ViewController.swift
//  CommonClass-Swift
//
//  Created by luowailin on 2019/12/11.
//  Copyright © 2019 luowailin. All rights reserved.
//

import UIKit

class Book{
    var bookName = "This is Swift Programing Language"
    var demoEscape:(()->())?
    func readBook() {
        showName {
            print("学Swift一定要看\(self.bookName)")
        }
    }
    
    //如果不加@escaping的话， Closures生命跟着函数一起结束， 
    func showName(show: @escaping ()->()){
        show()
        demoEscape = show
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        
        let tree:BinarySearchTree<Int> = BinarySearchTree.init()
        let arr = [7, 4, 9, 2, 5, 8]
        for i in arr {
            tree.add(i)
        }
        
        tree.preorderTraversalUsingBlock { (e) in
            print(e)
        }
        print("---------------")
        tree.remove(element: 7)
        tree.preorderTraversalUsingBlock { (e) in
            print(e)
        }
        /*
        let list:LinkedList<Int> = LinkedList.init()
        
        for i in 0..<10 {
            list.add(i+10)
        }
        print(list)
        
        print(list.remove(0))
        print(list.get(3))
        print(list)*/
    
        /*
        var p = Position(x: 10, y: 10)
        var s:Ship = Ship(position: p, firingRange: 30, unsafeRange: 20)
        let b = s.circle(radius: 10)


        let shifted = s.shift({ (point) -> Bool in

        }, by: p);
        let c = shifted
*/
        
        
        
        var john = Person(fullName: "john")
        john.fullName = "hello"
        
        let explain = {()->() in
            print("swift closures")
        }
        explain();
        
        codingSwift(day: 15, program:{ () -> String in
            return "猜数字"
        })
        
        //简化1  没有参数  [trailing closures]
        codingSwift(day: 23) { () -> String in
            return "订饮料"
        }
        
        codingSwift2(day: 1) { (day, text) in
            print("看了\(day)天的Swift,一定\(text)")
        }
        
        //简化2  有参数没有返回值把小括号去掉 [Inferring Type From Context]
        codingSwift2(day: 3) { day, text in
            print("看了\(day)天的Swift,一定\(text)")
        }
        
        //简化3 retrun只有一行代码 [Implicit Return from Single-Expression Closures]
        codingSwift(day: 40) { () -> String in
            "猜灯迷"  //只有一个return 省略return
        }
        
        //简化4 没有返回值有参数用默认的 [Shorthand Argument Names]
        codingSwift2(day: 1) {
            print("看了\($0)天的Swift,一定\($1) ")
        }
        
        //简化5 就是加减乘除 [Operator method]
        codingSwift3(day: 1, program: +)
        
        
        let b = Book.init()
        b.readBook()
        b.demoEscape!()
    }

    func codingSwift(day: Int, program:()->String) {
        print("study Swift 已经\(day)天, write \(program()) APP")
    }
    
    func codingSwift2(day: Int, program:(Int, String)->()){
        program(day, "看不懂")
    }
    
    func codingSwift3(day:Int, program:(String, String)->String) {
        let text = program("真的", "看不懂")
        print("看了\(day)天swift,一定\(text)")
    }
}

extension UIViewController{
    
}

