import Fluent

struct CreateUser: Migration {
  func prepare(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("users")
      .id()
      .field("name", .string, .required)
      .field("username", .string, .required)
      .create()
  }
  
  func revert(on database: Database) -> EventLoopFuture<Void> {
    return database.schema("users").delete()
  }
}
