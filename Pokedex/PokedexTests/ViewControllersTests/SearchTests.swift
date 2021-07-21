//
//  SearchTests.swift
//  PokedexTests
//
//  Created by Josué Arambula on 7/20/21.
//

import XCTest
import UIKit
@testable import Pokedex

class SearchTests: XCTestCase {

  var sut: PokeSearchViewController!

  override func setUp() {
    super.setUp()
  }

  override func setUpWithError() throws {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    sut = storyboard.instantiateViewController(withIdentifier: "SearchStoryboard") as? PokeSearchViewController

    sut.loadViewIfNeeded()
  }

  override func tearDownWithError() throws {
    sut = nil
  }

  func testSignupForm_WhenLoaded_TextFieldAreConnected() throws {
    _ = try XCTUnwrap(sut.pokeSearchView.searchBar, "The Search Bar UITextField is not connected")

  }

  func testTextField_WhenCreated_HasNameContentTypeSet() throws {
    let searchTextField = try XCTUnwrap(sut.pokeSearchView.searchBar, "The Search Bar UITextField is not connected")

    XCTAssertEqual(searchTextField.textContentType, UITextContentType.name, "Search UITextField does not have a Name Content Type set")
  }




}
