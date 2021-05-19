//
//  File.swift
//  
//
//  Created by Vladyslav Sosiuk on 19.05.2021.
//

import InstantMock
@testable import InstantMockRetainArgumentIssue

class ObjectUserMock: ObjectUser, MockDelegate {
    
    private let mock = Mock()
    var it: Mock {
        mock
    }
    
    override func useObject(_ object: Object) {
        it.call(object)
    }
}
