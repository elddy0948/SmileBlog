@testable import App
import XCTVapor

final class UserTests: XCTestCase {
  
  let usersName = "HoJoon"
  let usersUsername = "HoLuck"
  let usersURI = "/api/users/"
  var app: Application!
  
  override func setUpWithError() throws {
    app = try Application.testable()
  }
  
  override func tearDownWithError() throws {
    app.shutdown()
  }
  
  func testUsersCanBeRetrievedFromAPI() throws {
    let user = try User.create(
      name: usersName,
      username: usersUsername,
      on: app.db
    )
    
    _ = try User.create(on: app.db)
    
    try app.test(.GET, "api/users", afterResponse: { response in
      XCTAssertEqual(response.status, HTTPResponseStatus.ok)
      
      let users = try response.content.decode([User].self)
      
      XCTAssertEqual(users.count, 2)
      XCTAssertEqual(users[0].name, usersName)
      XCTAssertEqual(users[0].username, usersUsername)
      XCTAssertEqual(users[0].id, user.id)
    })
  }
  
  func testUserCanBeSavedWithAPI() throws {
    let user = User(name: usersName, username: usersUsername)
    
    try app.test(.POST, usersURI, beforeRequest: { req in
      try req.content.encode(user)
    }, afterResponse: { response in
      let receivedUser = try response.content.decode(User.self)
      XCTAssertEqual(receivedUser.name, user.name)
      XCTAssertEqual(receivedUser.username, user.username)
      XCTAssertNotNil(receivedUser.id)
      
      try app.test(.GET, usersURI, afterResponse: { secondResponse in
        let users = try secondResponse.content.decode([User].self)
        
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users[0].name, usersName)
        XCTAssertEqual(users[0].username, usersUsername)
        XCTAssertEqual(users[0].id, receivedUser.id)
      })
    })
  }
}
