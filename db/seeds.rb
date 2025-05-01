require 'faker'

# Create Admin
Admin.destroy_all
admin = Admin.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)
puts "Created admin: #{admin.email}"

# Create 100 weekly blog posts
BlogPost.destroy_all
100.times do |i|
  weeks_ago = 100 - i
  created_date = Date.today - weeks_ago.weeks
  # Set to Monday of that week
  created_date = created_date.beginning_of_week(:monday)

  # Generate random word count between 300 and 500
  word_count = rand(300..500)
  body = Faker::Lorem.paragraphs(number: (word_count / 20).to_i).join("\n\n")

  BlogPost.create!(
    title: "Weekly Blog Post ##{i + 1}",
    body: body,
    admin_id: admin.id,
    created_at: created_date,
    updated_at: created_date
  )
  puts "Created blog post: Weekly Blog Post ##{i + 1} for #{created_date.strftime('%Y-%m-%d')}"
end

puts "Seeded #{Admin.count} admin and #{BlogPost.count} blog posts"