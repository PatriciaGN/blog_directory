
TRUNCATE TABLE comments, posts RESTART IDENTITY;

INSERT INTO posts (title, post_content) VALUES ('My new post1', 'So many contents1!');
INSERT INTO posts (title, post_content) VALUES ('My new post2', 'So many contents2!');

INSERT INTO comments (comment_content, author_name, post_id ) VALUES ( 'This post is not so great...', 'Trollman', '1');
INSERT INTO comments (comment_content, author_name, post_id ) VALUES ( 'It can all be traced back to a childhood trauma.', 'FreeTherapist', '1');
INSERT INTO comments (comment_content, author_name, post_id ) VALUES ( 'LALALALALALA', 'ABBA', '2');
