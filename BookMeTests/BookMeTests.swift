//
//  BookMeTests.swift
//  BookMeTests
//
//  Created by Héctor Miranda García on 19/10/22.
//

import XCTest
@testable import BookMe
class BookMeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    var udr: Bool!
    func testConectividadConServer() async throws{
        let expectation = XCTestExpectation()
        
        let userDataController = BookMe.userAccountDataController()
        
        
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "loggedWithEmail")
        
        do{
            let str: String = "pepo117@Teco"
            let hashedP = ccSha256(data: str.data(using: .utf8)!)
            let thePassword = String(hashedP.map{ String(format: "%02hhx", $0) }.joined())
            let userData = try await userDataController.fetchUserAccountData(username_t: "pepo117", hashPassword_t: thePassword, completion: {result in
                self.udr = true
                DispatchQueue.main.async {
                    XCTAssertEqual(Bool(self.udr), true)
                    expectation.fulfill()
                }
            })
        }catch{
            XCTFail()
        }
        self.wait(for: [expectation], timeout: 5.0)
        
    }
    
    var hor: Bool!
    func testFetchTickets() async throws{
        let expectation = XCTestExpectation()
        
        let reservationDataController = BookMe.ReservationDataController()
        
        do{
            let hardwareObjs = try await reservationDataController.getHardwareObjects(completion: {result in
                print(result    )
                self.hor = true
                DispatchQueue.main.async {
                    XCTAssertEqual(Bool(self.hor), true)
                    expectation.fulfill()
                }
            })
        }catch{
            XCTFail()
        }
        self.wait(for: [expectation], timeout: 5.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
