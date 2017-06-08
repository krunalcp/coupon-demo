#
# Pagination Kaminari
#
PER_PAGE = 20

#
## Email validation
#
EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

#
## Allow Coupon
#
ALLOW_COUPON = [*1..30, 'unlimited']

#
## Duration
#
DURATION = {
  "One Day" => 1,
  "Two Day" => 2,
  "Weekly"  => 7,
  "Monthly" => 30,
  "No Restrictions" => -1,
  "Custom" => 'custom'
}

#
# set prefix type
#
PREFIX = [
  'Mr',
  'Miss',
  'Mrs'
]
