import Vapor
import Fluent

struct PostsController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let postsRoutes = routes.grouped("api", "posts")
    
    postsRoutes.get(use: getAllHandler(_:))
    postsRoutes.get(":postID", use: getHandler(_:))
    
    postsRoutes.post(use: createHandler(_:))
    
    postsRoutes.put(":postID", use: updateHandler(_:))
    
    postsRoutes.delete(":postID", use: deleteHandler(_:))
    
    postsRoutes.get(":postID", "user", use: getUserHandler(_:))
  }
  
  //MARK: - Create
  func createHandler(_ req: Request) throws -> EventLoopFuture<Post> {
    let data = try req.content.decode(CreatePostData.self)
    let post = Post(
      title: data.title,
      body: data.body,
      writer: data.writer,
      userID: data.userID)
    return post.save(on: req.db).map({ post })
  }
  
  //MARK: - Retrieve
  func getAllHandler(_ req: Request) -> EventLoopFuture<[Post]> {
    return Post.query(on: req.db).all()
  }
  
  func getHandler(_ req: Request) -> EventLoopFuture<Post> {
    let postID = req.parameters.get("postID").flatMap({ UUID($0) })
    return Post.find(postID, on: req.db)
      .unwrap(or: Abort(.notFound))
  }
  
  //MARK: - Update
  func updateHandler(_ req: Request) throws -> EventLoopFuture<Post> {
    let updatedPost = try req.content.decode(CreatePostData.self)
    let postID = req.parameters.get("postID").flatMap({ UUID($0) })
    
    return Post.find(postID, on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap({ post in
        post.title = updatedPost.title
        post.body = updatedPost.body
        post.editedAt = Date()
        post.$user.id = updatedPost.userID
        return post.save(on: req.db)
          .map({ post })
      })
  }
  
  //MARK: - Delete
  func deleteHandler(_ req: Request) -> EventLoopFuture<HTTPStatus> {
    let postID = req.parameters.get("postID").flatMap({ UUID($0) })
    return Post.find(postID, on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap({ post in
        return post.delete(on: req.db)
          .transform(to: .noContent)
      })
  }
  
  func getUserHandler(_ req: Request) -> EventLoopFuture<User> {
    let postID = req.parameters.get("postID").flatMap({ UUID($0) })
    return Post.find(postID, on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap({ post in
        post.$user.get(on: req.db)
      })
  }
}

struct CreatePostData: Content {
  let title: String
  let body: String
  let writer: String
  let createdAt: Date?
  let editedAt: Date?
  let userID: UUID
}
