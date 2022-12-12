import Vapor

struct Post: Content {
  let title: String
  let body: String
  let writer: String
  let createdAt: Date
  let updatedAt: Date
}

struct PostResponse: Content {
  let request: Post
}
