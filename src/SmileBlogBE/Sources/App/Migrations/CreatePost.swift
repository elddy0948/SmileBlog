import Fluent

struct CreatePost: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("posts")
      .id()
      .field("title", .string, .required)
      .field("body", .string, .required)
      .field("createdAt", .string, .required)
      .field("editedAt", .string, .required)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("posts").delete()
  }
}
