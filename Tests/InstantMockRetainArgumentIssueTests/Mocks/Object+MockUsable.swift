//
//  File.swift
//  
//
//  Created by Vladyslav Sosiuk on 19.05.2021.
//

import InstantMock
@testable import InstantMockRetainArgumentIssue

extension Object: MockUsable {
    private static let any = Object()
    public static var anyValue: MockUsable {
        any
    }
    
    public func equal(to value: MockUsable?) -> Bool {
        guard let value = value as? Self else {
            return false
        }
        return self === value
    }
}
