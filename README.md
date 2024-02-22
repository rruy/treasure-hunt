# Treasure Hunt

The objective of this application is to register a Treasure location using Latitude and Longitude coordinates.

Based on this location, participants can submit location suggestions to find this treasure using latitude and longitude coordinates.

Using the information provided by the user, the system calculates the distance using the Haversine formula to determine the distance between the two points: the treasure location and the suggested location. If the distance is less than 1000, the user is considered a winner.

### Technology:

This application uses:

- Ruby 3.2
- Rails 7
- PostgreSQL

#### Gems used:

- Devise / Devise Token
- Kaminari
- JsonApi-Serializer
- Rswag

#### Features:

- Authorization and Authentication with Devise.
- Serialization of JSON objects for response data from requests.
- Pagination allowing choice of fields and order (asc or desc).
- Documentation using Swagger API Docs.
- Distance calculation using the Haversine algorithm with Longitude and Latitude.

To run the application, execute the following commands:

```
bundle install
bundle exec rake db:create db:migrate db:seed
bundle exec rails s
```

### Routes to Use the System:

#### Register a new user:

URL: `localhost:3000/users`

Method: `POST`

Payload:

```json
{ 
  "name": "John",
  "email": "email@domain",
  "password": "pass123456",
  "password_confirmation": "pass123456"
}
```

This will return the application access token, similar to this:

```json
{
    "user": {
        "email": "email@domain",
        "provider": "email",
        "uid": "email@domain",
        "id": 2,
        "name": "John",
        "winner": true,
        "distance": 0,
        "created_at": "2024-02-21T14:27:58.241Z",
        "updated_at": "2024-02-22T17:25:03.414Z",
        "allow_password_change": false,
        "authentication_token": null
    },
    "token": "Bearer eyJhY2Nlc3MtdG9rZW4iOiJma2haRXdFMW5nQ19yNUlBa2ZaX2hnIiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6IlFQYno0aVZBSHZBd2ZETjhKaXV5bXciLCJleHBpcnkiOiIxNzA5ODMyMzAzIiwidWlkIjoidXNlcjJAZXhhbXBsZS5jb20ifQ=="
}
```

From now on, it will be necessary to pass the following parameter in the header of the requests:

```
Authorization: Bearer eyJhY2Nlc3MtdG9rZW4iOiJma2haRXdFMW5nQ19yNUlBa2ZaX2hnIiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6IlFQYno0aVZBSHZBd2ZETjhKaXV5bXciLCJleHBpcnkiOiIxNzA5ODMyMzAzIiwidWlkIjoidXNlcjJAZXhhbXBsZS5jb20ifQ==
```

If the correct token is not used, a 401 Not Authorized error will be returned.

#### To register a Treasure Location:

URL: `localhost:3000/treasure_locations`

Method: `POST`

Header: `Authorization : Bearer`

Payload:

```json
{
  "name": "Location Name",
  "latitude": 9.00,
  "longitude": 1.00,
  "active": true
}
```

#### To submit location suggestions for the treasure:

URL: `localhost:3000/guesses`

Method: `POST`

Header: `Authorization : Bearer`

Payload:

```json
{
    "latitude": -27.4421,
    "longitude": -48.5062
}
```

Based on the logged-in user, the application associates the `user_id` with the guess. If the distance is less than 1000, the `guessed` field in the Guess entity is set to true.

#### To list location suggestions for the treasure:

URL: `localhost:3000/guesses`

Method: `GET`

Header: `Authorization : Bearer`

#### To list only Winners:

URL: `localhost:3000/winners`

Method: `GET`

Header: `Authorization : Bearer`

#### To access the application documentation, visit the following URL:

URL: `localhost:3000/api-docs`

Method: `GET`

Example:

![Alt text](/public/swagger.png?raw=true "Api-Docs")

