import Foundation

struct Post {
  let id: UUID?
  let title: String
  let body: String
  let writer: String
  let editedAt: Date?
  let createdAt: Date?
  let user: User
}
