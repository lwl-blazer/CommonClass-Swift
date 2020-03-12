//
//  FunctionProgramming.swift
//  CommonClass-Swift
//
//  Created by blazer on 2020/2/22.
//  Copyright © 2020 luowailin. All rights reserved.
//

import Foundation

/**
 * 例子:判断一个给定的点是否在射程范围内，并且距离 友方船舶和我们自身都不太近。(战舰类游戏)
 */
typealias Distance = Double
struct Position {
    var x:Double
    var y:Double
}

extension Position {
    //检验一个点是否在一个区域内(如果自己位于原点直接使用此函数)
    func within(range: Distance) -> Bool {
        return sqrt(x * x + y * y) < range
    }
    
    //抽出运算
    func minus(_ p:Position)->Position{
        return Position(x:x - p.x, y:y - p.y);
    }
    
    func length() ->Double{
        return sqrt(x * x + y * y);
    }
}


/**
 *  以更加声明式的方式来判断一个区域内是否包含某个点
 *   定义一个i函数来判断一个点是否在范围内。
 *
 *  在函数式编程的核心理念就是函数是值，它和结构体、整型和布尔型没有区别
 */
typealias Region = (Position)->Bool

//船
struct Ship {
    var position:Position
    //可攻击的范围
    var firingRange:Distance
    var unsafeRange:Distance
}

extension Ship{
    //检验是否有另一艘船在范围内，不论自己是位于原点还是其它任何位置
    func canEngage(ship target:Ship) ->Bool{
        /*let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)*/
        //抽出后
        let targetDistance = target.position.minus(position).length()
        
        return targetDistance <= firingRange
    }
    
    //检验在自己位置在不安全范围外的敌人
    func canSafelyEngage(ship target:Ship) -> Bool{
        /*let dx = target.position.x - position.x;
        let dy = target.position.y - position.y;
        let targetDistance = sqrt(dx * dx + dy * dy);*/
        
        //抽出后
        let targetDistance = target.position.minus(position).length()
        
        return targetDistance <= firingRange && targetDistance > unsafeRange;
    }
    
    //避免目标船舶过于靠近我方任意一艘船
    func canSafelyEngage(ship target:Ship, friendly:Ship) -> Bool{
        /*let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        
        let friendlyDx = friendly.position.x - target.position.x
        let friendlyDy = friendly.position.y - target.position.y
        let friendlyDistance = sqrt(friendlyDx * friendlyDx + friendlyDy * friendlyDy)
 */
        //抽出后
        let targetDistance = target.position.minus(position).length()
        let friendlyDistance = friendly.position.minus(target.position).length()
        
        return targetDistance <= firingRange && targetDistance > unsafeRange && (friendlyDistance > unsafeRange);
    }
    
    //以原点为圆心的圆
    func circle(radius: Distance) ->Region{
        return {point in
            
            point.length() < radius
            
        } //用闭包来构造我们期待的返回函数
    }
    
    //center 是原点的意思 就是任意圆点为圆心的圆
    func circle2(radius: Distance, center: Position) -> Region{
        return {point in point.minus(center).length() <= radius}
    }
    
    func shift(_ region: @escaping Region, by offset: Position) -> Region {
        return {point in region(point.minus(offset))};
    }
}


