import express from 'express';
import path from 'path';
const app = express();
var router = express.Router();

import bodyParser from 'body-parser'

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }))

// parse application/json
app.use(bodyParser.json())

import mysql from 'mysql';

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  port: 3306,
  password: 'password',
  database: 'sql12373655',
  multipleStatements: true
});


// open the MySQL connection
connection.connect(error => {
  if (error) throw error;
  console.log("Successfully connected to the database.");
});

import mysql2 from 'mysql2/promise';
import fs from 'fs';

const conn = await mysql2.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'sql12373655',
  multipleStatements: true
});

const sql = fs.readFileSync('./project.sql').toString();
await conn.query(sql)
console.log("SQL File imported");
conn.end();


import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
app.set('view engine', 'ejs');

app.use(express.static(path.join(__dirname, 'public')));

app.use(express.static("public"));

// app.get('/admin', (req, res) => {
//   res.render('admin-panel');
// });

// app.get('/home', function (req, res, next) {
//   connection.query('Select * from Cabs', (err, result) => {
//     console.log(result)
//     if (err) throw err;
//     res.render('home');
//   })
// });


app.get('/', (req, res) => {
  res.render('start');
});

app.post('/sign_in', (req, res) => {
  console.log(req.body.email);
  console.log(req.body.password);
  connection.query('SELECT * FROM users WHERE email = ? AND password = ?', [req.body.email, req.body.password], (err, result) => {
    console.log(result);

    if (err) {
      console.log(err);
      res.sendStatus(500);
    } else if (result.length > 0) {
      // req.session.user = result[0];
      res.redirect('/home');
    } else {
      res.redirect('/?error=Invalid email or password');
    }
  });
});
app.get('/sign_in', (req, res) => {
  res.render('sign_in');
});

app.get('/add_user', function (req, res) {
  res.render('add_user');
});
app.post('/add_user', (req, res) => {
  console.log(req.body.email);
  console.log(req.body.password);
  connection.query('INSERT INTO users  VALUES("' + req.body.userid + '","' + req.body.name + '","' + req.body.email + '","' + req.body.password + '")', (err, result , fields) => {
    console.log(result);
    // 'Insert into MyBusReservation VALUES("' + req.body.busid + '","' + req.body.city1 + '",
      res.redirect('/sign_in')
    
  });
});

// app.post('/sign_in', (req, res) => {
//   // Get the user's input from the form
//   const email = req.body.email;
//   const password = req.body.password;

//   // Check if the email and password match a user in the database
//   connection.query('SELECT * FROM users WHERE email = ? AND password = ?', [email, password], (err, result) => {
//     if (err) throw err;
//     if (result.length >= 0) {
//       // If a user is found, set a session variable and redirect to the dashboard
//       req.session.users = result[0];
//       res.redirect('/home');
//     } else {
//       // If no user is found, redirect back to the sign-in page with an error message
//       res.redirect('/?error=Invalid email or password');
//     }
//   });
// });

app.get('/home', function (req, res, next) {
  connection.query('Select * from Cabs', (err, result) => {
    console.log(result)
    if (err) throw err;
    res.render('home');
  })
});

app.get('/explore', function (req, res) {
  connection.query('Select * from City', (err, result) => {
    res.render('explore', { data1: result, data2: result, data3: result });
  })
})
// select distinct city.city_name,nearby_city,hotel_name,restaurant_name from city,nearbycities,hotel,locality,restaurants where current_city=city.city_name && hotel.locality_id=locality.locality_id && restaurants.locality_id=locality.locality_id && current_city=? && locality.city_name=current_city;

app.post('/explore', function (req, res) {
  connection.query('SELECT DISTINCT nearby_city from nearbycities where current_city = ?;', [req.body.city], (err, result) => {
    if (err) {
      console.log(err);
      res.send("Error in executing query");
    } else {
      connection.query('SELECT DISTINCT hotel_name from hotel where hotel.hotel_city_name = ?;', [req.body.city], (err, result1) => {
        if (err) {
          console.log(err);
          res.send("Error in executing query");
        } else {
          connection.query('SELECT DISTINCT restaurant_name from restaurants where restaurants.city_name =?;', [req.body.city], (err, result2) => {
            if (err) {
              console.log(err);
              res.send("Error in executing query");
            } else {connection.query('SELECT * from PlaceToVisit where PlaceToVisit.city_name =?;', [req.body.city], (err, result3) => {
              if (err) {
                console.log(err);
                res.send("Error in executing query");
              } else {
                res.render('city', { data1: result, data2: result1 , data3: result2, data4: result3});
                console.log(result);
                console.log(result1);
                console.log(result2);
                console.log(result3);
              }
            });
            }
          });
        }
      });
    }
  });
});
// connection.query('select * from city_places', [req.body.city], (err, result) => {
//   res.render('explore', { data1: result });
//   console.log(result);
// })

// app.post('/bus', function (req, res) {
//   console.log(req.body);
//   connection.query('Select * from BusReservation where source =? and destination= ?', [req.body.city1, req.body.city2], (err, result, fields) => {
//     // console.log(data1);
//     res.render('book', { data1: result });
//     console.log(result);

//   })
// })

app.get('/city', function (req, res) {
  res.render('city');
});
app.post('/bus', function (req, res) {
  console.log(req.body);
  connection.query('Select * from BusReservation where source =? and destination= ?', [req.body.city1, req.body.city2], (err, result, fields) => {
    // console.log(data1);
    res.render('bus', { data1: result });
    console.log(result);

  })
})
app.post('/add-row', function (req, res) {
  // var bus_id = req.body.bus_id;
  console.log(req.body.bus_id, req.body.no_of_seats  );
  // Insert the data into the database
  connection.query('Insert into MyBusReservation VALUES("' + req.body.bus_id + '","' + req.body.no_of_seats + '")', function (err, result) {
    console.log(err);
      if (err) {
          // Send an error response
          res.json({ success: false });
      } else {
          // Send a success response
          res.json({ success: true });
      }
  });
});
app.post('/deleteRow', (req, res) => {
  const bus_id = req.body.bus_id;
  const seatCount = req.body.seatCount;
  console.log(req.body.bus_id, req.body.seatCount  );
  // Perform deletion operation in the database
  // Example using MySQL:
  connection.query('DELETE FROM MyBusReservation WHERE bus_id = ? AND total_seats = ?', [bus_id, seatCount], (error, results) => {
    console.log(error);
      if (error) {
          // Send an error response
          res.json({ success: false });
      } else {
          // Send a success response
          res.json({ success: true });
      }
  });
});





app.post('/addbus', (req, res) => {
  connection.query('Insert into MyBusReservation VALUES("' + req.body.busid + '","' + req.body.source + '", "' + req.body.destination + '", "' + req.body.departure_date + '", "' + req.body.seat_type + '", "' + req.body.total_seats + '")', (err, result, fields) => {
    console.log(req.body.busid, req.body.city1, req.body.city2, req.body.dd, req.body.st, req.body.noseat);

    // console.log(data1);
    res.redirect('/book')
  })
  // connection.query('Insert into City(city_name) VALUES("'+req.body.city1+'");)', (err, result, fields)=> {
  //   console.log(req.body.city1, req.body.city2, req.body.dd, req.body.st, req.body.noseat);

  //   // console.log(data1);
  //   res.redirect('/book')
  // })
})


app.post('/deletebus', (req, res) => {
  connection.query('delete from MyBusReservation where bus_id = ? and source = ? and destination = ? and departure_date= ? and seat_type = ?', [req.body.id, req.body.city1, req.body.city2, req.body.dd, req.body.st], (err, result, fields) => {
    console.log(req.body);
    res.redirect('/book');
    // console.log(result);
  })
})

app.get('/book', function (req, res) {
  connection.query('SELECT * from Bus;', (err, result) => {
    res.render('book', { data1: result });
    console.log(result);
  })
})

// app.post('/bus', function (req, res) {
//   connection.query('select distinct service_provider, is_ac,bus_id from city natural join bus natural join BusDepartureTime;', (err, result) => {
//     res.render('book', { data1: result });
//     console.log(result);
//   })
// })

app.get('/hotel', function (req, res) {
  connection.query('Select * from Hotel, locality where hotel.locality_id = locality.locality_id', (err, result) => {
    res.render('hotel', { data1: result });
  })
})

app.post('/hotel', function (req, res) {
  connection.query('Insert into hotel()', (err, result) => {
    res.render('hotel', { data1: result });
    console.log(result);
  })
})
app.post('/addhotel', function (req, res) {
  connection.query('Select * from Hotel, locality where hotel.locality_id = locality.locality_id', (err, result) => {
    res.render('hotel', { data1: result });
    console.log(result);
  })
})

const port = process.env.PORT || 3000;

app.listen(port, function () {
  console.log('App listening on port 3000!');
});
