//
//  Queue.swift
//  timesup
//
//  Created by Tim Harris on 3/10/18.
//  Copyright © 2018 Tim Harris. All rights reserved.
//

import Foundation


struct Node<T> {
    var value: T
    init(newValue: T) {
        self.value = newValue
    }
}

struct Queue<T> {
    var list:Array<Node<T>> = Array<Node<T>>()
    func Head() -> Node<T>? {
        guard let firstElement = list.first else {
            return nil
        }
        return firstElement
    }
    func Tail() -> Node<T>? {
        guard let lastElement = list.last else {
            return nil
        }
        return lastElement
    }
    mutating func Enqueue(newNode:Node<T>) -> Void {
        self.list.append(newNode)
    }
    mutating func Dequeue() -> Node<T>? {
        if self.Size() > 0  {
            let first = self.Head()!
            self.list.remove(at: 0)
            return first
        }
        return nil
    }
    func Size() -> Int {
        return list.count
    }
}
