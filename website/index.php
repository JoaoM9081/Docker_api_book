<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Docker | API</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <?php
    $result = file_get_contents("http://api:9001/books");
    $books = json_decode($result);
  ?>
  <div class="container">
    <table class="table">
      <thead>
        <tr>
          <th>Name</th>
          <th>Author</th>
          <th>Year</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach($books as $book): ?>
          <tr>
            <td><?php echo $book->name; ?></td>
            <td><?php echo $book->author; ?></td>
            <td><?php echo $book->year; ?></td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</body>
</html>