//
//  CharacterDetailTestCases.swift
//  OpenBankAssesmentBySachinKishoreTests
//
//  Created by Techugo on 10/02/22.
//

import XCTest

class CharacterDetailTestCases: XCTestCase {
    var characterModel : CharacterModel?
    var errorModel : ErrorModel?
    private var publicKey = getApiKeys()[Constants.publicKey.rawValue] ?? ""
    private var privateKey = getApiKeys()[Constants.privateKey.rawValue] ?? ""
    func testCharacterDetailApiResourceWithEmptyStringRturnsError() {
        let expectation = self.expectation(description: "testCharacterDetailApiResourceWithEmptyStringRturnsError")
        let url = "\(baseUrl)characters/?ts=&apikey=&hash="
    //   let url = "\(baseUrl)characters/\(self.charcterId ?? "")?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.code, "ResourceNotFound")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 20, handler: nil)
    }
    func testCharacterDetailApiResourceWithInvalidHashParametersRturnsError() {
        let expectation = self.expectation(description: "testCharacterDetailApiResourceWithInvalidHashParametersRturnsError")
        let url = "\(baseUrl)characters/-1?ts=22222&apikey=nfjndjfjdjf&hash=4r4r4rr44r"
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "The passed API key is invalid.")
            XCTAssertEqual(self.errorModel?.code, "InvalidCredentials")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 20, handler: nil)
    }
    func testCharacterDetailApiResourceWithMissingtsReturnsError() {
        let expectation = self.expectation(description: "testCharacterDetailApiResourceWithMissingtsReturnsError")
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters/1011334?apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "You must provide a timestamp.")
            XCTAssertEqual(self.errorModel?.code, "MissingParameter")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 20, handler: nil)
    }
    func testCharacterDetailApiResourceWithvalidHashParametersReturnsCorrectResponse() {
        let expectation = self.expectation(description: "testCharacterListApiResourceWithvalidHashParametersReturnsCorrectResponse")
        let ts = String(Int(Date().timeIntervalSinceNow))
        
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters/1011334?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.characterModel = try? jsonDecoder.decode(CharacterModel.self, from: jsonData!)
            XCTAssertNotNil(self.characterModel?.data?.results)
            XCTAssertEqual(self.characterModel?.status, "Ok")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 20, handler: nil)
    }
}
