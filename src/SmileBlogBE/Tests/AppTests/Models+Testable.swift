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
