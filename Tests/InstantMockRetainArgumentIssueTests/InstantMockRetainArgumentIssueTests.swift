import InstantMock
import XCTest
@testable import InstantMockRetainArgumentIssue
    
final class InstantMockRetainArgumentIssueTests: XCTestCase {
    
    // MARK: - SUT
    
    private var sut: Service!
    
    // MARK: - Mock
    
    private var objectFactoryMock: ObjectFactoryMock!
    private var objectUserMock: ObjectUserMock!
    
    override func setUp() {
        super.setUp()
        
        objectFactoryMock = ObjectFactoryMock()
        objectUserMock = ObjectUserMock()
        sut = Service(objectFactory: objectFactoryMock,
                      objectUser: objectUserMock)
    }
    
    override func tearDown() {
        sut = nil
        objectFactoryMock = nil
        objectUserMock = nil
        super.tearDown()
    }
    
    func testReleasesObjectOnStop() {
        // Setup
        var objectStub: Object? = Object()
        weak var weakObjectStub = objectStub
        objectFactoryMock
            .it
            .stub()
            .call(objectFactoryMock.make())
            .andReturn(objectStub!)
        
        // Expect
        objectUserMock
            .it
            .expect()
            .call(objectUserMock.useObject(Arg.eq(objectStub!)),
                  count: 1)
        
        // Execute
        sut.start()
        objectStub = nil
        XCTAssertNotNil(weakObjectStub) // Check if sut retained object stub
        sut.use()
        sut.stop()
        
        // Verify
        objectFactoryMock.it.resetStubs()
        objectUserMock.it.verify()
        objectUserMock.it.resetExpectations()
        objectUserMock.it.resetStubs()
        #warning("weakObjectStub variable expected to be nil (check sut doesn't retain it anymore) but it is retained by ArgumentStorageImpl.instance even after resetExpectations and resetStubs called on objectUserMock")
        XCTAssertNil(weakObjectStub) // Check if sut release object stub on stop()
    }
    func testReleasesObjectOnStop_UsingWorkaround() {
        // Setup
        var objectStub: Object? = Object()
        weak var weakObjectStub = objectStub
        objectFactoryMock
            .it
            .stub()
            .call(objectFactoryMock.make())
            .andReturn(objectStub!)
        
        // Expect
        objectUserMock
            .it
            .expect()
            .call(objectUserMock.useObject(Arg.eq(objectStub!)),
                  count: 1)
        
        // Execute
        sut.start()
        objectStub = nil
        XCTAssertNotNil(weakObjectStub) // Check if sut retained object stub
        sut.use()
        sut.stop()
        
        // Verify
        objectFactoryMock.it.resetStubs()
        objectUserMock.it.verify()
        objectUserMock.it.resetExpectations()
        objectUserMock.it.resetStubs()
        #warning("This call flushes ArgumentStorageImpl.instance storage so object is not retained anymore")
        objectUserMock.it.expect()
        XCTAssertNil(weakObjectStub) // Check if sut release object stub on stop()
    }
}
