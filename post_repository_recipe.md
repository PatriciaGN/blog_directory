1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: users

Columns:
id | title | post_content

2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.

TRUNCATE TABLE comments, posts RESTART IDENTITY;

INSERT INTO posts (title, post_content) VALUES ('My new post1', 'So many contents1!');
INSERT INTO posts (title, post_content) VALUES ('My new post2', 'So many contents2!');

INSERT INTO comments (comment_content, author_name, post_id ) VALUES ( 'This post is not so great...', 'Trollman', '1');
INSERT INTO comments (comment_content, author_name, post_id ) VALUES ( 'It can all be traced back to a childhood trauma.', 'FreeTherapist', '1');
INSERT INTO comments (comment_content, author_name, post_id ) VALUES ( 'LALALALALALA', 'ABBA', '2');

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 blog_directory < seeds.sql


3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: post

# Model class
# (in lib/post.rb)
class User
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

class User

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :post_contents
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, post_contents FROM posts WHERE id = $1;

    # Returns a single User object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(user)
     # Insert a new user record
     # Takes a User object in argument
     # Executes the SQL query: "INSERT INTO users (username, email_address) VALUES( $1, $2);"
     # Doesn't return anything (only creates the record)
  # end

  # def update(user)
    # Updates an user record
    # Takes a User objecty (with the updated fields)
    # Executes the SQL: "UPDATE users SET username = $1, email_account = $2, id = $3;"
    # Returns nothing(only updates the record)
  # end

  # def delete(user)
      # Deletes an user record given its id
      # Executes the SQL: "DELETE FROM users WHERE id = $1;"
      #Returns nothing
  # end
end

6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all posts

repo = UsersRepository.new

users = repo.all

users.length # =>  2

users[0].id # =>  1
users[0].username # =>  'username1'
users[0].email_address # =>  'email1@email.com'

users[1].id # =>  2
users[1].username # =>  'username2'
users[1].email_address # =>  'email2@email.com'


# 2
# Get a single post

repo = UsersRepository.new

users = repo.find(1)

users.id # =>  1
users.username # =>  'username1'
users.email_address # =>  'email1@email.com'

# 3 Creates a new post object with its atributes
repo = UsersRepository.new

users = Post.new
users.username = 'username1'
users.email_address = 'email1@email.com'

repository.create(user)

users #=> Post.new
users.username #=> 'username1'
users.email_address #=> 'email1@email.com'

# 4 Deletes a post
repo = UsersRepository.new

id_to_delete = 1
repo.delete(id_to_delete)
all_users = repo.all
all_users.length #=> 1

# 5 Updates a post
repo = UsersRepository.new

updated_user = repo.find(1)

updated_user.username = "updated username" 
updated_user.email_address = "updated@email.com"  

user.username #=> "updated username" 
user.email_address #=> "updated@email.com"  

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/posts_repository_spec.rb

def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'users' })
  connection.exec(seed_sql)
end

describe UsersRepository do
  before(:each) do 
    reset_users__table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
