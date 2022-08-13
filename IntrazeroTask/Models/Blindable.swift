//
//  imageModel.swift
//  IntrazeroTask
//
//  Created by Bassam on 8/11/22.
//

import Foundation

class Blindable<T>{
    var value: T?{
        didSet{
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(compeletion: @escaping (T?)->()){
        // set implementation of observer closure
        self.observer = compeletion
    }
}
enum State {
    case loading
    case error
    case empty
    case populated
}
