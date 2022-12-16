import Foundation

struct User {
  let id: UUID?
  let name: String
  let username: String
  let posts: [Post]
}
