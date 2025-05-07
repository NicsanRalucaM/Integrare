DROP TABLE IF EXISTS posts.anunt;
DROP TABLE IF EXISTS posts.comentarii;

CREATE TABLE posts.anunt (
    id SERIAL PRIMARY KEY,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT NOT NULL,
    kilometers INTEGER NOT NULL,
    userid TEXT NOT NULL,  
    carid INTEGER NOT NULL 
);

CREATE TABLE posts.comentarii (
    id SERIAL PRIMARY KEY,
    userid TEXT NOT NULL, 
    commenttext TEXT NOT NULL,
    anuntid INTEGER,
    CONSTRAINT fk_anuntid FOREIGN KEY (anuntid)
        REFERENCES posts.anunt(id)
        ON DELETE CASCADE
);

INSERT INTO posts.anunt (description, kilometers, userid, carid) VALUES
('Selling a Toyota Corolla, well maintained.', 150000, '1', 1),
('Audi A4 2015 available, diesel engine.', 90000, '1', 2),
('Honda Civic first owner, good condition.', 120000, '2', 3),
('BMW X5 2018, luxury SUV.', 50000, '4', 4),
('Ford Fiesta, reliable and economic.', 80000, '5', 5);

INSERT INTO posts.comentarii (userid, commenttext, anuntid) VALUES
('1', 'Is the Toyota still available?', 1),
('2', 'What is the final price for the Audi?', 2),
('1', 'Can you share more photos of the Honda Civic?', 3),
('2', 'I am interested in the BMW. Contact me.', 4),
('3', 'Great deal on the Ford Fiesta!', 5);

SELECT * FROM posts.anunt;
SELECT * FROM posts.comentarii;
