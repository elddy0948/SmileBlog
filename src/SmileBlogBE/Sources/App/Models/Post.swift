import Vapor
import Fluent

final class Post: Model {
  static let schema: String = "posts"
  
  @ID
  var id: UUID?
  
  @Field(key: "title")
  var title: String
  
  @Field(key: "body")
  var body: String
  
  @Field(key: "writer")
  var writer: String
  
  @Timestamp(key: "createdAt", on: .create)
  var createdAt: Date?
  
  @Timestamp(key: "editedAt", on: .update)
  var editedAt: Date?
  
  @Parent(key: "userID")
  var user: User
  
  init() {}
  
  init(
    id: UUID? = nil,
    title: String,
    body: String,
    writer: String,
    createdAt: Date? = Date(),
    editedAt: Date? = Date(),
    userID: User.IDValue
  ) {
    self.id = id
    self.title = title
    self.body = body
    self.writer = writer
    self.createdAt = createdAt
    self.editedAt = editedAt
    self.$user.id = userID
  }
}

extension Post: Content {}
