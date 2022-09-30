require "student"

class Post
    attr_accessor :id, :title, :post_content, :comments

    def initialize
        @comments = []
    end
end