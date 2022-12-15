# API docs

## User

### Get user

#### **GET**

- API Endpoint : "/api/users/{userID}"

- Response example
  ```json
  {
    "name": "HoJoon",
    "username": "HoLuck",
    "id": "2034E76C-CE14-4B4B-8AC0-2EC5948DBBA2"
  }
  ```

### Get all users

#### **GET**

- API Endpoint : "/api/users"

- Response example
  ```json
  [
    {
        "name": "HoJoon",
        "username": "HoLuck",
        "id": "17C2E115-4750-46C5-BA4B-0AEFE755B993"
    },
    {
        "name": "HoJoon",
        "username": "HoLuck",
        "id": "2034E76C-CE14-4B4B-8AC0-2EC5948DBBA2"
    }
  ]
  ```

### Get user's posts

#### **GET**

- API Endpoint : "/api/users/{userID}/posts"

- Response Example
  ```json
  [
    {
        "writer": "HoLuck",
        "id": "0D084E1E-E246-4F5D-B41C-E57A0EB0EF48",
        "title": "First post",
        "editedAt": null,
        "createdAt": null,
        "body": "Here is first post's body.",
        "user": {
            "id": "2034E76C-CE14-4B4B-8AC0-2EC5948DBBA2"
        }
    }
  ]
  ```

### Create user

#### **POST**

- API Endpoint : "/api/users"

- Request
  - name : String
  - username : String
  
- Response example
  ```json
  {
    "id": "2034E76C-CE14-4B4B-8AC0-2EC5948DBBA2",
    "name": "HoJoon",
    "username": "HoLuck"
  }
  ```
  
## Post

### Create post

#### **POST**

- API Endpoint : "/api/posts"

- Request
  - title   : String
  - body    : String
  - writer  : String
  - userID  : String 

- Response example
  ```json
  {
    "writer": "HoLuck",
    "id": "0D084E1E-E246-4F5D-B41C-E57A0EB0EF48",
    "title": "First post",
    "editedAt": "2022-12-15T16:46:07Z",
    "body": "Here is first post's body.",
    "createdAt": "2022-12-15T16:46:07Z",
    "user": {
        "id": "2034E76C-CE14-4B4B-8AC0-2EC5948DBBA2"
    }
  }
  ```

### Get all posts

#### **GET**

- API Endpoint : "/api/posts"

- Response example 
  ```json
  [
    {
        "writer": "HoLuck",
        "id": "68781A7C-9154-4A69-BD2A-BA26E8D49F5D",
        "title": "HoLuck's First post",
        "editedAt": null,
        "body": "It's me HoLuck. This is my first posting!",
        "createdAt": null,
        "user": {
            "id": "17C2E115-4750-46C5-BA4B-0AEFE755B993"
        }
    },
    {
        "writer": "HoLuck",
        "id": "0D084E1E-E246-4F5D-B41C-E57A0EB0EF48",
        "title": "First post",
        "editedAt": null,
        "body": "Here is first post's body.",
        "createdAt": null,
        "user": {
            "id": "2034E76C-CE14-4B4B-8AC0-2EC5948DBBA2"
        }
    }
  ]
  ```

### Get post

#### **GET**

- API Endpoint : "/api/posts/{postID}"

- Response example
  ```json
  {
      "writer": "HoLuck",
      "id": "0D084E1E-E246-4F5D-B41C-E57A0EB0EF48",
      "title": "First post",
      "editedAt": null,
      "body": "Here is first post's body.",
      "createdAt": null,
      "user": {
          "id": "2034E76C-CE14-4B4B-8AC0-2EC5948DBBA2"
      }
  }
  ```

### Update post

#### **PUT**

- API Endpoint : "/api/posts/{postID}"

- Request
  - title   : String
  - body    : String
  - writer  : String
  - userID  : String

- Response example
  ```json
  {
    "writer": "HoLuck",
    "id": "0D084E1E-E246-4F5D-B41C-E57A0EB0EF48",
    "title": "edited title",
    "createdAt": null,
    "body": "edited body",
    "editedAt": "2022-12-15T16:58:01Z",
    "user": {
        "id": "2034E76C-CE14-4B4B-8AC0-2EC5948DBBA2"
    }
  }
  ```

### Delete post

#### **DELETE**

- API Endpoint : "/api/posts/{postID}"

This will returns Status code 200 `OK`
or `error code`

### Get post's user

#### **GET**

- API Endpoint : "/api/posts/{postID}/user"

- Response example
  ```json
  {
    "id": "17C2E115-4750-46C5-BA4B-0AEFE755B993",
    "username": "HoLuck",
    "name": "HoJoon"
  }
  ```
  
// TODO : - 바로가기 만들어두기
