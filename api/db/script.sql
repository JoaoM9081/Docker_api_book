CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- criando a tabela de livros com o ano de lançamento
CREATE TABLE IF NOT EXISTS books (
    id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    PRIMARY KEY (id)
);

-- inserindo dados na tabela de livros com o ano de lançamento
INSERT INTO books (name, author, year) VALUES ('The Lord of the Rings', 'J.R.R. Tolkien', 1954);
INSERT INTO books (name, author, year) VALUES ('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 1997);
INSERT INTO books (name, author, year) VALUES ('1984', 'George Orwell', 1949);
INSERT INTO books (name, author, year) VALUES ('To Kill a Mockingbird', 'Harper Lee', 1960);
INSERT INTO books (name, author, year) VALUES ('Pride and Prejudice', 'Jane Austen', 1813);