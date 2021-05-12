# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
9.times do |i|
  HeadLine.create(
    source: "http://www.google.com/ #{i + 1}",
    content_id: "ID- #{i + 1}",
    title: "Extra Extra Extra !!! #{i + 1}",
    link: "http://www.google.com",
	scrape_date: DateTime.strptime("09/01/2021 19:00", "%m/%d/%Y %H:%M")
  )
end