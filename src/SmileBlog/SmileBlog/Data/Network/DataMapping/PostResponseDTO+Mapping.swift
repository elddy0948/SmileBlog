import Foundation

struct PostResponseDTO: Decodable {
  let id: UUID?
  let title: String
  let body: String
  let writer: String
  let createdAt: Date?
  let editedAt: Date?
  let user: [String: UUID?]
}

extension PostResponseDTO {
  func toDomain() -> Post {
    Post(
      id: self.id,
      title: self.title,
      body: self.body,
      writer: self.writer,
      editedAt: self.editedAt,
      createdAt: self.createdAt,
      user: self.user
    )
  }
}
