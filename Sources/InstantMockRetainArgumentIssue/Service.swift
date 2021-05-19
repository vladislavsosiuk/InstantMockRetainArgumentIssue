//
//  File.swift
//  
//
//  Created by Vladyslav Sosiuk on 19.05.2021.
//

import Foundation

class Service {
    
    // MARK: - Dependencies
    
    private let objectFactory: ObjectFactory
    private let objectUser: ObjectUser
    
    // MARK: - Private Properties
    
    private var object: Object?
    
    // MARK: - Init
    
    init(objectFactory: ObjectFactory,
         objectUser: ObjectUser) {
        self.objectFactory = objectFactory
        self.objectUser = objectUser
    }
    
    func start() {
        object = objectFactory.make()
        object?.doWork()
    }
    
    func use() {
        objectUser.useObject(self.object!)
    }
    
    func stop() {
        object = nil
    }
}
