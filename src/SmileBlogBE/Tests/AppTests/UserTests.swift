@testable import App
import XCTVapor

final class UserTests: XCTestCase {
  func testUsersCanBeRetrievedFromAPI() throws {
    let expectedName = "HoJoon"
    let expectedUsername = "HoLuck"
    
    let app = Application(.testing)
    
    defer { app.shutdown() }
    
    try configure(app)
    
    try app.autoRevert().wait()
    try app.autoMigrate().wait()
    
    let user = User(name: expectedName, username: expectedUsername)
    
    try user.save(on: app.db).wait()
    
    try User(name: "Joon", username: "joons")
      .save(on: app.db)
      .wait()
    
    try app.test(.GET, "api/users", afterResponse: { response in
      XCTAssertEqual(response.status, HTTPResponseStatus.ok)
      
      let users = try response.content.decode([User].self)
      
      XCTAssertEqual(users.count, 2)
      XCTAssertEqual(users[0].name, expectedName)
      XCTAssertEqual(users[0].username, expectedUsername)
      XCTAssertEqual(users[0].id, user.id)
    })
  }
}
