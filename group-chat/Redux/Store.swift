//
//  Store.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 08..
//

import Combine

protocol Store {
    associatedtype State
    associatedtype Action
    var state: Published<State>.Publisher { get }
    
    func reduce(_ action: Action)
}
