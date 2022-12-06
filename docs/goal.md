# 목표 설정

# 🏆 최종 목표

- [ ]  Swift로 만들어진 Vapor를 활용하여 직접 구현한 서버에서 게시물이 생성, 수정, 삭제, 읽기가 가능하고, 댓글 작성이 가능한 상태의 iOS 앱 만들기

# 🔥 목표

## 🎯 게시글의 CRUD를 위한 서버 구현

- [ ]  Vapor와 Heroku를 사용하여 글 CRUD가 가능한 서버를 직접 구현 → 서버를 직접 구현하면서 서버의 동작 방식에 대해 조금 더 깊게 이해하기

## 🎯 블로그 UI 디자인

- [ ]  Figma를 사용하여 Blog UI를 설계 해둔다(메인 화면, 관리자 화면, 게시글 작성 화면), medium이라는 앱을 참고 → 대략적인 디자인을 설계해두면서 개발하면서 자주 수정하지 않게 하기
- [ ]  스토리 보드를 사용하지 않고, 코드만을 사용하여 UI를 구성 → 코드로만 AutoLayout을 구성하면서 AutoLayout에 대한 이해력을 높이기

## 🎯 글 쓰기 / 목록 / 수정 / 삭제 기능 구현

- [ ]  GCD를 활용하여 서버와 통신시 background에서 작업을 수행할 수 있도록 구현 → qos, main queue와의 차이점 등에 대해 정확하게 이해하기 위해 Raywenderlich, Apple Developer doc 를 정독
- [ ]  UITableView를 활용하여 글 목록 보여주는 기능 구현하기, Header View를 활용해 최신 글 개수 보여주는 기능 구현
    - [ ]  [➕Optional] : 글 수정 및 작성시 CoreData를 활용해서 임시 저장 기능 구현
- [ ]  게시글 작성/ 수정 기능은 UITextView를 활용하여 Plain Text 글 쓰기 형태로 구현
    - [ ]  [➕Optional] : 게시글에 사진 지원까지 구현
- [ ]  글 목록의 Pagination 기능을 UITableView의 제일 아래에 도달하면 추가적인 데이터를 받아올 수 있게 구현 → 서버에서는 Pagination 기능을 어떻게 구현하는지 찾아보기

## 🎯 댓글

- [ ]  댓글의 길이에 상관없이 유동적으로 잘 보여줄 수 있게 self-sizing 이 지원되는 UITableViewCell 구현
- [ ]  하나의 게시물에 여러개의 댓글을 달 수 있게 하는 모델

## 🎯 관리자 도구

- [ ]  글을 작성했던 작성자 기준으로 관리자를 판별하는 로직을 작성

## 🎯 추가적인 목표

- [ ]  Clean Architecture(https://github.com/sergdort/CleanArchitectureRxSwift) 이 github에 있는 내용들을 이해하고 프로젝트에 직접 적용해보기
- [ ]  RxSwift에 의존하지 않는 MVVM 패턴 구현해보기
    
    → MVVM 형태로 구현된 GitHub의 다양한 오픈소스를 참조하기
    
- [ ]  개발하면서 발생했던 모든 해결 방법들을 GitHub 저장소에 기록하기
