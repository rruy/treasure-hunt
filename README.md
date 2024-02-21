# README

## Treasure Hunt Game

### Run application execute this commands

```
$ bundle install
$ rake db:create db:migrate
$ rails s
```

### Create a new user

POST localhost:3000/api/sign_up
Payload Json:

```
  {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
```


### Authorization User

POST localhost:3000/api/sign_in
Payload Json:

```
{
  "email": "user@example.com",
  "password": "password123"
}
```

### Access Informations about Winners
GET localhost:3000/api/winners?page=1
Headers: 

```
Authorization: Bearer eyJhY2Nlc3MtdG9rZW4iOiJUaWNZUTF4TWFrUzF4R0t0dnhVVXp3IiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6IlNNTkV6WWk4NFRZZ25GVTc3eTViSWciLCJleHBpcnkiOiIxNzA5NzMxNTE3IiwidWlkIjoidXNlckBleGFtcGxlLmNvbSJ9
```