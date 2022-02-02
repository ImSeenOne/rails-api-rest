require "test_helper"
require "faker"

class PostControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  #Populates DB
  setup do
    @logger = Logger.new(STDOUT)
    Post.create([{ title: Faker::name, content: Faker::Lorem.paragraph_by_chars(number: 210)}, { title: Faker::name, content: Faker::Lorem.paragraph_by_chars(number: 210)}, { title: Faker::name, content: Faker::Lorem.paragraph_by_chars(number: 210)}, { title: Faker::name, content: Faker::Lorem.paragraph_by_chars(number: 210)}])
  end

  test "Retrieves post by id" do
    @post = Post.select("id", "title", "content").where(id: 298486374, deleted_at: nil).take
    assert (@post.present? == true)
  end

  test
end
