@testable import App
import XCTVapor

final class UserTests: XCTestCase {
  
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
      username: usersUsername,
      on: app.db
    )
    
    _ = try User.create(on: app.db)
    
    try app.test(.GET, "api/users", afterResponse: { response in
      XCTAssertEqual(response.status, HTTPResponseStatus.ok)
      
      let users = try response.content.decode([User].self)
      
      XCTAssertEqual(users.count, 2)
      XCTAssertEqual(users[0].username, usersUsername)
      XCTAssertEqual(users[0].id, user.id)
    })
  }
  
  func testUserCanBeSavedWithAPI() throws {
    let user = User(username: usersUsername)
    
    try app.test(.POST, usersURI, beforeRequest: { req in
      try req.content.encode(user)
    }, afterResponse: { response in
      let receivedUser = try response.content.decode(User.self)
      XCTAssertEqual(receivedUser.username, user.username)
      XCTAssertNotNil(receivedUser.id)
      
      try app.test(.GET, usersURI, afterResponse: { secondResponse in
        let users = try secondResponse.content.decode([User].self)
        
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users[0].username, usersUsername)
        XCTAssertEqual(users[0].id, receivedUser.id)
      })
    })
  }
  
  func testGettingASingleUserWithAPI() throws {
    let user = try User.create(
      username: usersUsername,
      on: app.db
    )
    
    try app.test(.GET, "\(usersURI)\(user.id!)", afterResponse: { response in
      let receivedUser = try response.content.decode(User.self)
      
      XCTAssertEqual(receivedUser.username, usersUsername)
      XCTAssertEqual(receivedUser.id, user.id)
    })
  }
  
  func testGettingAUsersPostsWithAPI() throws {
    let user = try User.create(on: app.db)
    let postTitle = "First posting"
    let postBody = "First post body here"
    let postWriter = "HoLuck"
    
    let post1 = try Post.create(
      title: postTitle,
      body: postBody,
      writer: postWriter,
      createdAt: nil,
      editedAt: nil,
      user: user,
      on: app.db
    )
    
    _ = try Post.create(
      title: "Hello",
      body: "Hello body!",
      writer: "helloMan",
      createdAt: nil,
      editedAt: nil,
      user: user,
      on: app.db
    )
    
    try app.test(.GET, "\(usersURI)\(user.id!)/posts", afterResponse: { response in
      let posts = try response.content.decode([Post].self)
      XCTAssertEqual(posts.count, 2)
      XCTAssertEqual(posts[0].id, post1.id)
      XCTAssertEqual(posts[0].title, postTitle)
      XCTAssertEqual(posts[0].body, postBody)
      XCTAssertEqual(posts[0].writer, postWriter)
    })
  }
}
