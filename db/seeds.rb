#
## Admin User
#
unless Admin.any?
  Admin.create!(
    email:                  'admin@coupon-demo.com',
    password:               '12345678',
    password_confirmation:  '12345678'
  )
end
