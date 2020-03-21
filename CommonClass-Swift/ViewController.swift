//
//  ViewController.swift
//  CommonClass-Swift
//
//  Created by luowailin on 2019/12/11.
//  Copyright © 2019 luowailin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
start()
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
        
    }

}

extension UIViewController{
    
}

