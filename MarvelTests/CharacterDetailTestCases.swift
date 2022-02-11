//
//  CharacterDetailTestCases.swift
//  MarvelTests
//
//  Created by Techugo on 11/02/22.
//

import XCTest

class CharacterDetailTestCases: XCTestCase {

    var characterModel : CharacterModel?
    var errorModel : ErrorModel?
    private var publicKey = getApiKeys()[Constants.publicKey.rawValue] ?? ""
    private var privateKey = getApiKeys()[Constants.privateKey.rawValue] ?? ""
 
    //MARK: Test Character Detail Api Resource With Empty String and RturnsError
    func testCharacterDetailApiResourceWithEmptyStringRturnsError() {
        let expectation = self.expectation(description: "emptyString")
        let url = "\(baseUrl)characters/?ts=&apikey=&hash="
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.code, "ResourceNotFound")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test Character Detail Api Resource With Invalid Parameters and RturnsError
    func testCharacterDetailApiResourceWithInvalidHashParametersRturnsError() {
        let expectation = self.expectation(description: "invalid")
        let url = "\(baseUrl)characters/-1?ts=22222&apikey=nfjndjfjdjf&hash=4r4r4rr44r"
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "The passed API key is invalid.")
            XCTAssertEqual(self.errorModel?.code, "InvalidCredentials")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test Character Detail Api Resource With Missing Time stamp and RturnsError
    func testCharacterDetailApiResourceWithMissingtsReturnsError() {
        let expectation = self.expectation(description: "missingTimeStamp")
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
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test Character Detail Api Resource With valid Parameters and Correct Response
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
        waitForExpectations(timeout: 5, handler: nil)
    }

}

