require "post_repository"

def reset_posts_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_directory' })
    connection.exec(seed_sql)
end

RSpec.describe PostRepository do
    before(:each) do
        reset_posts_table
    end

  describe "#find" do
    it "finds a post with related comments" do
        repo = PostRepository.new
        post = repo.find_with_comments(1)

        expect(post.title).to eq("My new post1")
        expect(post.comments.length).to eq 2
    end
  end
end