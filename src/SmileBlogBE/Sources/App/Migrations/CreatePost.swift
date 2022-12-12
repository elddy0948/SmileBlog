import Fluent

struct CreatePost: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    database.schema("posts")
      .id()
      .field("title", .string, .required)
      .field("body", .string, .required)
      .field("writer", .string, .required)
      .field("createdAt", .time, .required)
      .field("editedAt", .time, .required)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("posts").delete()
  }
}
