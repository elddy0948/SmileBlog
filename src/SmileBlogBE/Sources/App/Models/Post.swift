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
  
  @Field(key: "createdAt")
  var createdAt: Date
  
  @Field(key: "editedAt")
  var editedAt: Date
  
  init() {}
  
  init(
    id: UUID? = nil,
    title: String,
    body: String,
    writer: String,
    createdAt: Date = Date(),
    editedAt: Date = Date()
  ) {
    self.id = id
    self.title = title
    self.body = body
    self.writer = writer
    self.createdAt = createdAt
    self.editedAt = editedAt
  }
}

extension Post: Content {}
