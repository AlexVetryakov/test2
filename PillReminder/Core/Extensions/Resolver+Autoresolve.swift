//
//  Resolver+Autoresolve.swift
//  PillReminder
//
//  Created by Александр Ветряков on 23.01.2024.
//

import Swinject
import SwinjectAutoregistration

public extension Resolver {
    
    func autoresolve<T>() -> T! {
        return resolve(T.self)
    }
    
    func autoresolve<T>(name: String) -> T! {
        return resolve(T.self, name: name)
    }
    
    func autoresolve<T, Arg1>(argument: Arg1) -> T! {
        return resolve(T.self, argument: argument)
    }
    
}
