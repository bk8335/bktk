# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name: 'Tech')
Category.create(name: 'Investing')
Category.create(name: 'Trading')
Category.create(name: 'Personal Finance')
Category.create(name: 'Reading')

Post.create(title: 'First blog post', content: 'blabla', category_id: Category.first.id, author: 'bla', draft: false)

Position.create(asset: 'Tesla',	ticker: 'TSLA', long_or_short: 'short', initial_price: 317.76, post_id: Post.first.id)