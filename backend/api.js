const express = require('express');
const mysql = require('mysql');
const cors = require('cors')
const path = require('path');
const approve = require('approvejs');
const uuid = require('uuid/v4');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const passport = require('passport');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const LocalStrategy = require('passport-local').Strategy;
const Order = require('./Order.js');


const app = express();
app.use(cors());
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(cookieParser());

const data = new Date();

let orders = []
let debugauth = false;
//setInterval(el => console.log(orders[0]),5000);

const db = mysql.createConnection({
  host    : 'localhost',
  user    : 'booksapp',
  password: '123',
  database: 'booksapp'
})

db.connect((err) => {
  if(err) throw err;
  console.log(aktualnaData()+'MySql Connected...');
});

const sessionStore = new MySQLStore({
    expiration: 10800000,
    createDatabaseTable: true,
    schema: {
        tableName: 'sessions',
        columnNames: {
            session_id: 'session_id',
            expires: 'expires',
            data: 'data'
}}}, db);

// configure passport.js to use the local strategy
passport.use(new LocalStrategy(
  (username, password, done) => {
    if (debugauth) console.log('Inside local strategy callback')
    db.query(`select us_id id, us_login login, us_password password, us_roleID roleID, us_storeID storeID from users where us_login = "${username}"`,(err, result) => {
        if (err){return console.log(err)};
        const user = result[0];
        if (debugauth) console.log('Użytkownik z Local: ',username, typeof username,password, typeof password);
        if (typeof user === 'undefined') {return done(true, false);}
        if (debugauth) console.log('Użytkownik z bazy: ',user.login ,typeof user.login, user.password,typeof user.password);
        if(username == user.login && password == user.password) {
          if (debugauth) console.log('Local strategy returned true')
          return done(false, user)
        }else{
          if (debugauth) console.log('Local strategy returned false')
          return done(true, false);
        }
      });
    }
));

// tell passport how to serialize the user
passport.serializeUser((user, done) => {
  if (debugauth) console.log('Inside serializeUser callback. User id is save to the session file store here')
  done(null, user.id);
});

passport.deserializeUser((id, done) => {
  if (debugauth) console.log('Inside deserializeUser callback')
  if (debugauth) console.log(`The user id passport saved in the session file store is: ${id}`)
  db.query(`select us_id id, us_login login, us_password password, us_roleID roleID, us_storeID storeID from users where us_id = "${id}"`, function (err, rows){
      if (debugauth) console.log('rows: ', rows);
      if (typeof rows !== 'undefined') return  done(err, rows[0]);
      done(err, null);
  });
});

// add & configure middleware
app.use(session({
  genid: (req) => {
    console.log('Inside the session middleware')
    console.log(req.sessionID)
    return uuid() // use UUIDs for session IDs
  },
  store: sessionStore,
  secret: 'keyboard cat',
  resave: true,
  saveUninitialized: true
}))

app.use(passport.initialize());
app.use(passport.session());

app.use(function(req, res, next) {
  if (debugauth) console.log('wypisanie użytkownika')
    if (req.path.indexOf('.css') === -1 && req.path.indexOf('.js') === -1 ){
      if (debugauth) {
        console.log("\n\n\nścieżka: ", req.path);
        if (typeof req.user !== 'undefined') console.log("użytkownik: ", req.user.username);
        else console.log("Brak użytkownika");
        console.log('-------------------------- session -----------------------------------------');
        console.dir(req.sessionID);
        console.log('------------------------------------------------------------------------------------');
        console.log('-------------------------- cookies -----------------------------------------');
        console.dir(req.cookies);
        console.log('------------------------------------------------------------------------------------');
        console.log('-------------------------- user -----------------------------------------');
        console.dir(req.user);
        console.log('------------------------------------------------------------------------------------');
      }
    }
    next();
  });

  app.use(function(req, res, next) {
    if (debugauth) console.log('kontrola użytkownika')
    if(typeof req.user === 'undefined' && req.path.indexOf('api/') >= 0){
      if (debugauth) console.log(req.path,'odesłałem do logowania')
      return res.send({error:"401",res:null});
    }

    // if (typeof req.user === 'undefined' && req.path.indexOf('/logowanie/') !== 0 && req.path.indexOf('/css/') !== 0 && req.path.indexOf('/js/') !== 0 && req.path.indexOf('/images/') !== 0  && req.path.indexOf('/favicon') !== 0 && req.path !== '/signin' && req.path !== '/signup')
    //   {
    //      console.log("Przekierowywuje Cie do logowania");
    //      return  res.redirect('/signin');
    //   }
    //   if (typeof req.user !== 'undefined' && req.path.indexOf('/logowanie') !== -1)
    //   {
    //     console.log("Jestes juz zalogowany, po co sie logowac drugi raz?");
    //     return  res.redirect('/');
    //   }
    next();
  });

app.post('/signin', (req, res, next) => {
  if (debugauth) console.log(req.body);
  if (debugauth) console.log('Inside the new POST /login callback')
  passport.authenticate('local', (err, user, info) => {
    if (debugauth) console.log("(err, user, info)",err, user, info);
    if (err || !user) return res.send({error:"Nie udało się uwierzytelnic",res:null});
    if (debugauth) console.log('Inside passport.authenticate() callback');
    if (debugauth) console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
    if (debugauth) console.error(`req.user: ${JSON.stringify(req.user)}`)
    req.login(user, (err) => {
      if (debugauth) console.error('Inside req.login() callback', err)
      //console.error('Inside req.login() callback')
      if (debugauth) console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
      if (debugauth) console.log(`req.user: ${JSON.stringify(req.user)}`);
      return res.send({error:null,res:req.user});
    })
  })(req, res, next)
});
//
// app.post('/signup', (req, res, next) => {
//   let  body = req.body;
//   const spr = sprawdzRejestracja(body);
//   if (Object.keys(spr).length > 0) return res.send({error:'Błędne dane',message:spr});
//   const sql = 'INSERT INTO users SET ?';
//   const query = db.query(sql,body, (err, result) => {
//     if (err) {
//       console.error(err);
//       return res.send({error:err,res:null});
//     }
//       return res.send({error:null, res:'Zarejestrowano pomyślnie'})
//   })
// });

app.get('/logout', (req, res) => {
  req.logout();
  res.send({error:null,res:"ok"});
});



app.get('/api/orders', (req,res) => {
  let sql =`select * from orders`
  loadOrdersFromSql()
  .then(orders =>{
    res.send({err:null,res:orders});
  })
  .catch(error =>{
    res.send({err:error,res:null});
  });
  // console.log(sql)
  // sendSql(res, sql)
  return 0;
});


app.post('/api/orders',(req,res) => {
  console.log(req.body)
  let orderObj = req.body
  console.log('user', req.user)
  orderObj.details.user = ifExsistElse(req.user,{id:0}) //TODO
  let order = new Order(orderObj)
  order.writeToSql(writeSql).then(result=>{
    return res.send({err:null,res:result});
  }).catch(err=>{return res.send({error:err,res:null})});
  orders.push(order)
  return 0;
});

app.get('/api/books',(req,res) => {
  let sql =`select bo_ID id, bo_title title, bo_printhouse printHouse ,bo_ISBN isbn, bo_printdate printdate, bo_category category, bo_description description, bo_author author, bo_price price, di_value discountValue, di_name discountName from books
            left join discount_elements on del_bookID = bo_id
            left join discounts on del_discountid = di_ID and now() > di_confirmDate and now() < di_endDate`
  //console.log(sql)
  return sendSql(res, sql)
});

app.get('/api/users',(req,res) => {
  let sql =`select * from users`
  sendSql(res, sql)
});



app.get('/api/customers',(req,res) => {
  let sql =`select cu_ID id,cu_company company,cu_NIP nip,cu_firstName firstName,cu_lastName lastName,cu_email email,cu_creatorID creatorID,cu_creatorTS creatorTS,cu_modTS modTS,cu_modID modID,cu_isArchival isArichval, di_value discountValue, di_name discountName from customers
            left join discount_customer on cu_id = dc_customerid
            left join discounts on dc_discountid = di_ID and now() > di_confirmDate and now() < di_endDate`
  //console.log(sql)
  return sendSql(res, sql)

});

app.get('/api/addresses', (req,res) => {
  let sql =`SELECT ad_ID id,ad_name name,ad_address1 address1,ad_address2 address2,ad_city city,ad_postalCode postalCode,ca_customerID customerID FROM address ad
            join customeraddress ca on ca_addressid = ad_ID`
  return sendSql(res, sql)
});

app.post('/api/addresses', (req,res) => {
  const { ad_name, ad_address1, ad_city, ad_postalCode } = req.body;
  const sql = `INSERT INTO address (ad_name, ad_address1, ad_city, ad_postalCode)
    VALUES ("${ad_name}","${ad_address1}","${ad_city}","${ad_postalCode}")`;
  sendSql(res, sql);
});

app.post('/api/users', (req,res) => {
  const {us_login, us_email, us_password, us_roleID, us_storeID } = req.body;
  const sql = `INSERT INTO users (us_login, us_email, us_password, us_roleID, us_storeID)
    VALUES ("${us_login}","${us_email}","${us_password}","${us_roleID}","${us_storeID}")`;
  sendSql(res, sql);

});

app.post('/api/shipments', (req,res) => {
  const {si_ID,si_type, si_number, si_status } = req.body;
  const sql = `INSERT INTO shipments (si_ID,si_type, si_number, si_status )
    VALUES ("${si_ID}","${si_type}","${si_number}","${si_status}")`;
  sendSql(res, sql);

});
app.post('/api/status', (req,res) => {
  const {or_ID } = req.body;
  const sql = `UPDATE orders SET or_status = '3' WHERE or_ID = ${or_ID}`;
  sendSql(res, sql);

});
app.post('/api/orderStatus', (req,res) => {
  const {or_ID } = req.body;
  const sql = `UPDATE orders SET or_status = '4' WHERE or_ID = ${or_ID}`;
  sendSql(res, sql);

});
app.post('/api/shipmentStatus', (req,res) => {
  const {or_ID } = req.body;
  const sql = `UPDATE shipments SET osi_status = 'zrealizowano' WHERE or_ID = ${or_ID}`;
  sendSql(res, sql);

});

app.get('/api/warehouses', (req,res) => {
  let sql =`SELECT wa_ID id,wa_code code, ad.ad_city city FROM warehouses wa
  join address ad on wa.wa_addressID = ad.ad_id`
  return sendSql(res, sql)
});

app.get('/api/stores',(req,res) => {
  let sql =`SELECT  st_ID id,  st_name 'name',  st_shortName 'shortName',  st_addressID 'addressID',  st_warehouseID 'warehouseID' FROM  store`
  return sendSql(res, sql)
});

app.use(express.static('../frontend/'));


app.use(function(req, res, next) {
 return res.status(404).send({error:'Route '+req.url+' Not found.',res:null});
});

app.listen(3000, () => console.log(aktualnaData()+'Listen on port 3000....'))


function writeSql(sql)
{
  return new Promise(function(resolve, reject) {
    const query = db.query(sql, (err, result) => {
      if (err){console.error(err); reject(err)};
      //console.log(result);
      resolve(result)
    });
  })
}

function sendSql(res,sql)
{
  return new Promise(function(resolve, reject) {
    const query = db.query(sql, (err, result) => {
      if (err){console.error(err); reject(err);  return res.send({error:err,res:null})};
      //console.log(result);
      resolve(result)
      return res.send({err:null,res:result});
    });
  })
}

function loadOrdersFromSql(id){
  return new Promise((resolve,reject)=>{
    let where = '';
    if (typeof id != 'undefined'){ where = `where or_id = '${id}'`}
    let sql = `select * from orders
               join order_books on or_id = ob_orderid
               ${where}`;
     writeSql(sql).then(resp  => {
       let orders = {};
        resp.forEach(el=>{
          if (typeof orders[el.or_ID] == 'undefined') orders[el.or_ID] = { details:{}, books:[] };
          let book = {};
          Object.keys(el).forEach(field=>{
          if (field.substring(0,2) == 'or'){
            orders[el.or_ID].details[field.replace('_ID','_id').substring(3)] = el[field];
          }
          if (field.substring(0,2) == 'ob'){
            book[field.replace('_ID','_id').substring(3)] = el[field];
          }
          })
          orders[el.or_ID].books.push(book);
        })
        let tab = [];
        Object.keys(orders).forEach(el => {
          tab.push(orders[el]);
        })
        resolve(tab);
     }).catch(error => {console.error(error);reject(error);});
   })
}

function aktualnaData(){
  const rok = leadingZero(data.getFullYear());
  const miesiac = leadingZero(data.getMonth()+1);
  const dzien = leadingZero(data.getDate());
  const godz = leadingZero(data.getHours());
  const min = leadingZero(data.getMinutes());
  const sec = leadingZero(data.getSeconds());
  return `[${dzien}.${miesiac}.${rok} ${godz}:${min}:${sec}] `
}

function leadingZero(i) {
  return (i < 10)? '0'+i : i;
}

function ifExsistElse(one, two = null){
  if (typeof one !== 'undefined' && one !== null)  return one
  return two
}
