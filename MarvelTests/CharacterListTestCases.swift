//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Techugo on 11/02/22.
//

import XCTest
@testable import Marvel

class CharacterListTestCases: XCTestCase {
    var characterModel : CharacterModel?
    var errorModel : ErrorModel?
    private var publicKey = getApiKeys()[Constants.publicKey.rawValue] ?? ""
    private var privateKey = getApiKeys()[Constants.privateKey.rawValue] ?? ""
    
    //MARK: Test Character List Api Resource With Empty String and RturnsError
    func testCharacterListApiResourceWithEmptyStringRturnsError() {
        let expectation = self.expectation(description: "emptyString")
        let url = "\(baseUrl)characters?ts=&apikey=&hash="
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "The passed API key is invalid.")
            XCTAssertEqual(self.errorModel?.code, "InvalidCredentials")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    //MARK: Test Character List Api Resource With Invalid Hash Parameters and RturnsError
    func testCharacterListApiResourceWithInvalidHashParametersRturnsError() {
        let expectation = self.expectation(description: "invalidHash")
        let url = "\(baseUrl)characters?ts=22222&apikey=nfjndjfjdjf&hash=4r4r4rr44r"
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "The passed API key is invalid.")
            XCTAssertEqual(self.errorModel?.code, "InvalidCredentials")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test Character List Api Resource With Missing TimeStamp and RturnsError
    func testCharacterListApiResourceWithMissingtsReturnsError() {
        let expectation = self.expectation(description: "missedTimeStamp")
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters?apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "You must provide a timestamp.")
            XCTAssertEqual(self.errorModel?.code, "MissingParameter")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test Character List Api Resource With Valid Parameters and returns Correct Response
    func testCharacterListApiResourceWithvalidHashParametersReturnsCorrectResponse() {
        let expectation = self.expectation(description: "validParametes")
        let ts = String(Int(Date().timeIntervalSinceNow))
        
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.characterModel = try? jsonDecoder.decode(CharacterModel.self, from: jsonData!)
            XCTAssertNotNil(self.characterModel?.data?.results)
            XCTAssertEqual(self.characterModel?.status, "Ok")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
}

