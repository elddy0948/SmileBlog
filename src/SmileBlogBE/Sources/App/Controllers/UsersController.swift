import Vapor
import Fluent

struct UsersController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let usersRoute = routes.grouped("api", "users")
    
    usersRoute.post(use: createHandler(_:))
    
    usersRoute.get(use: getAllHandler(_:))
    usersRoute.get(":userID", use: getHandler(_:))
    
    usersRoute.get(":userID", "posts", use: getPostsHandler(_:))
    
    usersRoute.get("search", use: searchHandler(_:))
  }
  
  //MARK: - Create
  func createHandler(_ req: Request) throws -> EventLoopFuture<User> {
    let user = try req.content.decode(User.self)
    return user.save(on: req.db).map({ user })
  }
  
  //MARK: - Retrieve
  func getAllHandler(_ req: Request) -> EventLoopFuture<[User]> {
    return User.query(on: req.db).all()
  }
  
  func getHandler(_ req: Request) -> EventLoopFuture<User> {
    let userID = req.parameters.get("userID").flatMap({ UUID($0) })
    return User.find(userID, on: req.db)
      .unwrap(or: Abort(.notFound))
  }
  
  func getPostsHandler(_ req: Request) -> EventLoopFuture<[Post]> {
    let userID = req.parameters.get("userID").flatMap({ UUID($0) })
    return User.find(userID, on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap({ user in
        user.$posts.get(on: req.db)
      })
  }
  
  func searchHandler(_ req: Request) throws -> EventLoopFuture<User> {
    guard let searchTerm = req.query[String.self, at: "username"] else {
      throw Abort(.badRequest)
    }
    
    return User.query(on: req.db)
      .filter(\.$username == searchTerm)
      .first()
      .unwrap(or: Abort(.notFound))
  }
}
