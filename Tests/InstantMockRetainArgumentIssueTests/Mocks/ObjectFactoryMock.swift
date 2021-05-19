//
//  File.swift
//  
//
//  Created by Vladyslav Sosiuk on 19.05.2021.
//

import InstantMock
@testable import InstantMockRetainArgumentIssue

class ObjectFactoryMock: ObjectFactory, MockDelegate {
    private let mock = Mock()
    var it: Mock {
        mock
    }
    override func make() -> Object {
        it.call()!
    }
}
