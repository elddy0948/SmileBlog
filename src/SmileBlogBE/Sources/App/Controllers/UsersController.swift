import Vapor

struct UsersController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let usersRoute = routes.grouped("api", "users")
    
    usersRoute.post(use: createHandler(_:))
    
    usersRoute.get(use: getAllHandler(_:))
    usersRoute.get(":userID", use: getHandler(_:))
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
}
