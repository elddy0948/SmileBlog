import Fluent
import Vapor

func routes(_ app: Application) throws {
  app.get { req async throws in
    try await req.view.render("index", ["title": "Hello Vapor!"])
  }
  
  app.get("hello") { req async -> String in
    "Hello, world!"
  }
  
  //MARK: - Create
  app.post("api", "posts", use: { req -> EventLoopFuture<Post> in
    let post = try req.content.decode(Post.self)
    return post.save(on: req.db).map({ post })
  })
  
  //MARK: - Retrieve
  app.get("api", "posts", use: { req -> EventLoopFuture<[Post]> in
    return Post.query(on: req.db).all()
  })
  
  app.get("api", "posts", ":postID", use: { req -> EventLoopFuture<Post> in
    let postID = req.parameters.get("postID").flatMap({ UUID($0) })
    return Post.find(postID, on: req.db)
      .unwrap(or: Abort(.notFound))
  })
  
  //MARK: - Update
  app.put("api", "posts", ":postID", use: { req -> EventLoopFuture<Post> in
    let updatePost = try req.content.decode(Post.self)
    let postID = req.parameters.get("postID").flatMap({ UUID($0) })
    return Post.find(postID, on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap({ post in
        post.title = updatePost.title
        post.body = updatePost.body
        post.editedAt = Date()
        return post.save(on: req.db).map({ post })
      })
  })
  
  //MARK: - Delete
  app.delete("api", "posts", ":postID", use: { req -> EventLoopFuture<HTTPStatus> in
    return Post.find(req.parameters.get("postID"), on: req.db)
      .unwrap(or: Abort(.notFound))
      .flatMap({ post in
        post.delete(on: req.db)
          .transform(to: .noContent)
      })
  })
}
