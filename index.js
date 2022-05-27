var express = require('express');
var app = express();
app.get('/', function (req, res) {
  res.send('Hello World!');
});

var mysql = require('mysql');

var con = mysql.createConnection({
  host: "127.0.0.1",
  user: "root",
  password: "password", 
  database:"library"
});
var books;
app.get("/books", (req,res)=>{
    con.connect(function(err) {
        if (err) throw err;
        con.query("SELECT * FROM book", function (err, result, fields) {
          if (err) throw err;
          console.log(result);
          books=result
          res.send(books)
        });
      });

})




app.listen(3000, function () {
    console.log('Example app listening on port 3000!');
  });