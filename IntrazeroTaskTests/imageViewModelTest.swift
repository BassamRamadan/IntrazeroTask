//
//  imageViewModelTest.swift
//  IntrazeroTaskTests
//
//  Created by Bassam on 8/17/22.
//

import XCTest
@testable import IntrazeroTask

class imageViewModelTest: XCTestCase {
    var imageViewModel: ImageViewModel!
    
    func testInitialization(){
        imageViewModel = ImageViewModel()
        XCTAssertNotNil(imageViewModel, "The image view model should not be nil.")
    }
    
}
