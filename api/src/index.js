// importando express e mysql
const express = require('express');
const mysql = require('mysql2');

const app = express();

// criando a conexão com o banco de dados
const connection = mysql.createConnection({
  host: 'mysql-container',
  user: 'root',
  password: 'passwordroot',
  database: 'biblioteca'
});

connection.connect();

// criando a rota para listar os livros
app.get('/books', function(req,res) {
  connection.query('SELECT * FROM books', function (error, results) {

    if (error) { 
      console.error(error);
      res.status(500).send('Internal server error');
      return;
    };

    res.send(results.map(item => ({  
      name: item.name, 
      author: item.author,
      year: item.year
     })));
  });
});

// criando a rota para listar os autores
app.listen(9001, '0.0.0.0', function() {
  console.log('Listening port 9001');
})