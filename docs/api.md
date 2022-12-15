# API docs

## User

### Get user

#### GET

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

#### GET

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

#### GET

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
