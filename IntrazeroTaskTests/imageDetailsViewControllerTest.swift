//
//  imageDetailsViewControllerTest.swift
//  IntrazeroTaskTests
//
//  Created by Bassam on 8/17/22.
//

import XCTest
@testable import IntrazeroTask

class imageDetailsViewControllerTest: XCTestCase {
    var imageDetails: imageDetailsViewController!
    var model: imageModel!
    func testImageInitialization(){
        imageDetails = imageDetailsViewController()
        XCTAssertNotNil(imageDetails, "The image view model should not be nil.")
    }
    
    func testModelInitialization(){
        model = imageModel(id: "0", author: "Alejandro Escamilla", downloadURL: "https://picsum.photos/id/0/5616/3744")
        XCTAssertNotNil(model, "The model should not be nil.")
    }
    
    func testImageDetails_ImageInfo(){
        imageDetails = imageDetailsViewController()
        model = imageModel(id: "0", author: "Alejandro Escamilla", downloadURL: "https://picsum.photos/id/0/5616/3744")
        imageDetails.imageInfo = model
        XCTAssertNotNil(imageDetails.imageInfo, "The image info should not be nil.")
    }
    
    
    
}
