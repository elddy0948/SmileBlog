import Fluent
import Vapor

func routes(_ app: Application) throws {
  app.get { req async throws in
    try await req.view.render("index", ["title": "Hello Vapor!"])
  }
  
  app.get("hello") { req async -> String in
    "Hello, world!"
  }
  
  app.post("api", "posts", use: { req -> EventLoopFuture<Post> in
    let post = try req.content.decode(Post.self)
    return post.save(on: req.db).map({ post })
  })
}
