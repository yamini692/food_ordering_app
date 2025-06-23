User.create!(
  name: "Yamini",
  email: "yaminir@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: "Customer"
)

User.create!(
  name: "Admin",
  email: "admin@example.com",
  password: "admin123",
  password_confirmation: "admin123",
  role: "Restaurant"
)
