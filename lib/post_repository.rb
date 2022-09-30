require "post"
require "comment"

class PostRepository
    def find_with_comments(id)
        sql = 'SELECT posts.id,
                  posts.title,
                  posts.post_content,
                  comments.id AS comment_id,
                  comments.comment_content,
                  comments.author_name,
                  comments.post_id
               FROM posts
               JOIN comments ON comments.post_id = posts.id
               WHERE posts.id = $1;'
    
      
    
        sql_params = [id]
        result = DatabaseConnection.exec_params(sql, sql_params)
    
        post = Post.new
        post.id = result.first['id']
        post.title = result.first['title']
        post.post_content = result.first['post_content']
        
        
        result.each do |record|
            comment = Comment.new
            comment.id = record['comment_id']
            comment.comment_content = record['comment_content']
            comment.post_id = record['post']
    
            post.comments << comment
        end
        return post
      end

end