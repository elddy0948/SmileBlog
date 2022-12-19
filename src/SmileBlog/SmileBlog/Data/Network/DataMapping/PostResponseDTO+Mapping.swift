//
//  PostResponseDTO+Mapping.swift
//  SmileBlog
//
//  Created by 김호준 on 2022/12/19.
//

import Foundation

struct PostResponseDTO: Decodable {
  let id: UUID?
  let title: String
  let body: String
  let writer: String
  let createdAt: Date?
  let editedAt: Date?
  let user: UserResponseDTO
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
      user: self.user.toDomain()
    )
  }
}
