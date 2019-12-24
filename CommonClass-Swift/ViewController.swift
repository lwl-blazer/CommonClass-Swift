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

        view.backgroundColor = UIColor.red
        let tree:BinarySearchTree<Int> = BinarySearchTree.init()
        let arr = [7, 4, 9, 2, 5, 8]
        for i in arr {
            tree.add(i)
        }
        
        tree.postorderTraversalUsingBlock{ (e) in
            print(e)
        }
        
        let list:LinkedList<Int> = LinkedList.init()
        
        for i in 0..<10 {
            list.add(i+10)
        }
        print(list)
        
        print(list.remove(0))
        print(list.get(3))
        print(list)
    }
}


