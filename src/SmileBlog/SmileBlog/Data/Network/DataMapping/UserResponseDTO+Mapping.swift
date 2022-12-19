import Foundation

struct UserResponseDTO: Decodable {
  let id: UUID?
  let name: String
  let username: String
}

extension UserResponseDTO {
  func toDomain() -> User {
    return User(
      id: self.id,
      name: self.name,
      username: self.username)
  }
}
