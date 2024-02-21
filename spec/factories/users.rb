FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'john@example.com' }
    password { 'password' }
    authentication_token { 'Bearer eyJhY2Nlc3MtdG9rZW4iOiI0ZURHeDBtaW5hbmhOc0hNRlBYVVJ3IiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6IlQwRk9KaUlwbXdJcURWU0xKcDFrR2ciLCJleHBpcnkiOiIxNzA5NzM1Mjk0IiwidWlkIjoidXNlcjJAZXhhbXBsZS5jb20ifQ==' }
  end
end
