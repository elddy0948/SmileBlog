import Fluent
import Vapor

final class User: Model, Content {
  static let schema: String = "users"
  
  @ID
  var id: UUID?
  
  @Field(key: "name")
  var name: String
  
  @Field(key: "username")
  var username: String
  
  init() {}
  
  init(id: UUID? = nil, name: String, username: String) {
    self.name = name
    self.username = username
  }
}
