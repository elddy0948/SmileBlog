import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  
  let databaseName: String
  let databasePort: Int
  
  if (app.environment == .testing) {
    databaseName = "vapor-test"
    databasePort = 5433
  } else {
    databaseName = "vapor_database"
    databasePort = 5432
  }
  
  app.databases.use(.postgres(
    hostname: Environment.get("DATABASE_HOST") ?? "localhost",
    port: databasePort,
    username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
    password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
    database: Environment.get("DATABASE_NAME") ?? databaseName
  ), as: .psql)
  
  app.views.use(.leaf)
  
  app.migrations.add(CreateUser())
  app.migrations.add(CreatePost())
  
  app.logger.logLevel = Logger.Level.debug
  
  try app.autoMigrate().wait()
  
  // register routes
  try routes(app)
}
