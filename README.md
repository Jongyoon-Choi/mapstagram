# Mapstagram
Mapstagram은 장소 평가 기반 소셜 네트워크 서비스입니다. Android Studio와 Flutter를 사용하여 개발되었으며, Firebase를 데이터베이스로 사용합니다.

## 1. 프로젝트 소개
본 프로젝트를 통해 기존의 장소 검색 포털(e.g., 네이버 블로그, 네이버 플레이스, 구글맵 등)의 광고나 부적절한 리뷰로 인해 객관적인 탐색이 어려운 점과 참여율이 저조하고 리뷰를 남기기 꺼려하는 점을 개선하고자 한다. 이를 위해 Mapstagram에서는 자연스럽게 자신의 일상을 공유하는 SNS의 특성을 이용하여 장소 검색과 SNS를 하나의 앱에서 제공하는 서비스를 제공하고자 한다. 

## 2. 프로젝트 기능
### 2-1. 장소와 평점을 사용한 게시물
게시물에 장소와 평점 정보를 추가하여 장소에 대한 정보를 제공합니다.

### 2-2. 장소별 평점 제공
게시물의 정보를 활용하여 장소별 평균 평점과 게시물 수를 지도에 표시합니다. 장소 탐색을 쉽고 편리하게 사용할 수 있습니다.

### 2-3. 푸시 알림 전송
특정 조건을 만족하면 사용자에게 주변 추천 장소 알림을 전송합니다. 이를 통해 사용자의 게시물 작성과 참여를 유도합니다.

## 3. 인터페이스
| 로그인 화면 |
|------|
|![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/0507c96f-a494-4cda-89ff-e8dc656de542) ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/f297fe23-ac11-4047-bb09-595b8ee8f171) ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/6694578f-d564-4db6-9250-9788d42c3dba)|

| 게시물 작성 |
|------|
| ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/551b1a71-995f-45d0-9da0-18781f218a94) ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/129142d0-e6f6-4368-a8a8-4fe44e84e589)|

| 홈 화면 | 게시물 추천 및 검색  |
|------|------|
| ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/494268a4-f572-451a-bb84-244366903920) | ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/0c2f758f-6a61-46d9-9fb3-b64e8b335b69) | ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/fa2a350a-b2ad-4cd2-800d-d26f03dd2379) |

| 장소 검색 | 마이페이지 | 푸시 알림 |
|------|------|------|
| ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/fa2a350a-b2ad-4cd2-800d-d26f03dd2379) | ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/11e0b766-b1b0-49d6-b144-e7fd794f3858) | ![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/80c08a0b-f98f-453b-9b82-ef331eed6777) |

## 4. 팀원 소개
| 최종윤 | 이시원 | 임성현 |
|------|------|------|
| 20200293 | 20192858 | 20203126 |

## 5. 기술 스택
| 역할 | 종류 |
|------|------|
| Framework | ![image](https://camo.githubusercontent.com/df7ab2a6c45b04e44de2c8641ef87cba4617625cd31935efb57721a4e0a351b2/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f466c75747465722d3032353639423f7374796c653d666f722d7468652d6261646765266c6f676f3d666c7574746572266c6f676f436f6c6f723d7768697465) |
| Database | ![image](https://camo.githubusercontent.com/94157aefeada12eba9df1b8ee0e62f44b062486cf3166941ec801b93aa747ee9/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f46697265626173652d4646434132382e7376673f267374796c653d666f722d7468652d6261646765266c6f676f3d4669726562617365266c6f676f436f6c6f723d7768697465) |
| Programming Language | ![image](https://camo.githubusercontent.com/2081d92c054dbf7eec9521ade73051ed66fb9ccffb53e33213585fbf23ec2d52/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446172742d3031373543323f7374796c653d666f722d7468652d6261646765266c6f676f3d64617274266c6f676f436f6c6f723d7768697465) |
| Device | ![image](https://camo.githubusercontent.com/611f645753539e9348c8e98c2699b360cc9fa726a59c49b25893b511bd488df9/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f416e64726f69642d34413835333f7374796c653d666f722d7468652d6261646765266c6f676f3d416e64726f6964266c6f676f436f6c6f723d7768697465) |

## 6. 시스템 구조
![image](https://github.com/Jongyoon-Choi/mapstagram/assets/129063106/c9c8da7d-3db6-4c7b-93fd-3aefba0f6a60)
