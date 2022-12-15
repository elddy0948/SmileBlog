@testable import App
import Fluent

extension User {
  static func create(
    name: String = "Joon",
    username: String = "joons",
    on database: Database
  ) throws -> User {
    let user = User(name: name, username: username)
    try user.save(on: database).wait()
    return user
  }
}

extension Post {
  static func create(
    title: String = "Test posting",
    body: String = "This is test posting!",
    writer: String = "tester",
    createdAt: Date? = nil,
    editedAt: Date? = nil,
    user: User? = nil,
    on database: Database
  ) throws -> Post {
    var postsUser = user
    
    if postsUser == nil {
      postsUser = try User.create(on: database)
    }
    
    let post = Post(
      title: title,
      body: body,
      writer: writer,
      userID: postsUser!.id!
    )
    
    try post.save(on: database).wait()
    
    return post
  }
}
