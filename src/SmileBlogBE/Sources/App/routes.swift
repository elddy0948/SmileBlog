import Fluent
import Vapor

func routes(_ app: Application) throws {
  let postsController = PostsController()
  try app.register(collection: postsController)
  
  let usersController = UsersController()
  try app.register(collection: usersController)
}
