# README

## Treasure Hunt Game

This appplication use:

 - Ruby 3.2
 - Rails 7
 - Postgres
  
The objective this application is to compare two locations, one where can find the treasure and other from guess user location, case the guess location distance is less than 1000 the user is the Winner. The sistem can is set user as the winner only time. The sistem should identify that user already won and return error.

All information about this challenge can be found in home page.

#### Run application execute this commands

```
$ bundle install
$ rake db:create db:migrate
$ rails s
```

#### Create a new user

POST localhost:3000/api/sign_up

Payload Json:

```
  {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
```


#### Authorization User

POST localhost:3000/api/sign_in

Payload Json:

```
{
  "email": "user@example.com",
  "password": "password123"
}
```

#### Access Informations about Winners
GET localhost:3000/api/winners?page=1

Headers: 

```
Authorization: Bearer eyJhY2Nlc3MtdG9rZW4iOiJUaWNZUTF4TWFrUzF4R0t0dnhVVXp3IiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6IlNNTkV6WWk4NFRZZ25GVTc3eTViSWciLCJleHBpcnkiOiIxNzA5NzMxNTE3IiwidWlkIjoidXNlckBleGFtcGxlLmNvbSJ9
```


### Swagger Api Docs

To access api-docs with swagger user this URL
```
localhost:3000/api-docs
```

Examples:

#### Auth

![Alt text](/public/Swagger-1.png?raw=true "Auth")

#### Sign_In

![Alt text](/public/Swagger-2.png?raw=true "Sign_in")

#### Guess

![Alt text](/public/Swagger-3.png?raw=true "Guess")

#### List of winners

![Alt text](/public/Swagger-4.png?raw=true "Winners")