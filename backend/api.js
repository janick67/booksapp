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

const app = express();
app.use(cors());
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(cookieParser());

const data = new Date();

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
    console.log('Inside local strategy callback')
    db.query(`select * from users where username = "${username}"`,(err, result) => {
        if (err){return console.log(err)};
        const user = result[0];
        console.log('Użytkownik z Local: ',username, typeof username,password, typeof password);
        if (typeof user === 'undefined') {return done(true, false);}
        console.log('Użytkownik z bazy: ',user.username ,typeof user.username, user.password,typeof user.password);
        if(username == user.username && password == user.password) {
          console.log('Local strategy returned true')
          return done(false, user)
        }else{
          console.log('Local strategy returned false')
          return done(true, false);
        }
      });
    }
));

// tell passport how to serialize the user
passport.serializeUser((user, done) => {
  //console.log('Inside serializeUser callback. User id is save to the session file store here')
  done(null, user.id);
});

passport.deserializeUser((id, done) => {
//  console.log('Inside deserializeUser callback')
  //console.log(`The user id passport saved in the session file store is: ${id}`)
  db.query(`select * from users where id = "${id}"`, function (err, rows){
      //console.log('rows: ', rows);
        done(err, rows[0]);
  });
});

// add & configure middleware
app.use(session({
  genid: (req) => {
    console.log('Inside the session middleware')
  //  console.log(req.sessionID)
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
    if (req.path.indexOf('.css') === -1 && req.path.indexOf('.js') === -1 ){
        console.log("\n\n\nścieżka: ", req.path);
        if (typeof req.user !== 'undefined') console.log("użytkownik: ", req.user.username);
        else console.log("Brak użytkownika");
        // console.log('-------------------------- session -----------------------------------------');
        // console.dir(req.sessionID);
        // console.log('------------------------------------------------------------------------------------');
        // console.log('-------------------------- cookies -----------------------------------------');
        // console.dir(req.cookies);
        // console.log('------------------------------------------------------------------------------------');
        // console.log('-------------------------- user -----------------------------------------');
        // console.dir(req.user);
        // console.log('------------------------------------------------------------------------------------');
    }
    next();
  });

  app.use(function(req, res, next) {
    // if(typeof req.user === 'undefined' && req.path.indexOf('api/') >= 0){
    //   return res.status(404).send({error:"Najpierw się zaloguj",res:null});
    // }
    // if (typeof req.user === 'undefined' && req.path.indexOf('/logowanie/') !== 0 && req.path.indexOf('/css/') !== 0 && req.path.indexOf('/js/') !== 0 && req.path.indexOf('/images/') !== 0  && req.path.indexOf('/favicon') !== 0 && req.path !== '/signin' && req.path !== '/signup')
    //   {
    //      console.log("Przekierowywuje Cie do logowania");
    //      return  res.redirect('logowanie/index.html');
    //   }
    //   if (typeof req.user !== 'undefined' && req.path.indexOf('/logowanie') !== -1)
    //   {
    //     console.log("Jestes juz zalogowany, po co sie logowac drugi raz?");
    //     return  res.redirect('/');
    //   }
      next();
  });

app.post('/signin', (req, res, next) => {
  console.log('Inside the new POST /login callback')
  passport.authenticate('local', (err, user, info) => {
    console.log("(err, user, info)",err, user, info);
    if (err || !user) return res.send({error:"Nie udało się uwierzytelnic",res:null});
    //console.log('Inside passport.authenticate() callback');
    //console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
    ///console.log(`req.user: ${JSON.stringify(req.user)}`)
    req.login(user, (err) => {
      console.log('Inside req.login() callback')
      console.log(`req.session.passport: ${JSON.stringify(req.session.passport)}`)
      console.log(`req.user: ${JSON.stringify(req.user)}`);
      return res.send({error:null,res:"Zalogowano pomyślnie"});
    })
  })(req, res, next)
});

app.post('/signup', (req, res, next) => {
  let  body = req.body;
  const spr = sprawdzRejestracja(body);
  if (Object.keys(spr).length > 0) return res.send({error:'Błędne dane',message:spr});
  const sql = 'INSERT INTO users SET ?';
  const query = db.query(sql,body, (err, result) => {
    if (err) {
      console.error(err);
      return res.send({error:err,res:null});
    }
      return res.send({error:null, res:'Zarejestrowano pomyślnie'})
  })
});

app.get('/logout',(req, res) => {
  req.logout();
  res.send({error:null,res:"ok"});
  res.redirect('/');
});


function sprawdzRejestracja(body){
  return {};
}

app.get('/api/orders',(req,res) => {
  let sql =`select * from orders`
  console.log(sql)
  sendSql(res, sql)

});

app.use(express.static('../frontend/'));


app.use(function(req, res, next) {
  return res.status(404).send({error:'Route '+req.url+' Not found.',res:null});
});

app.listen(3000, () => console.log(aktualnaData()+'Listen on port 3000....'))


function sendSql(res,sql)
{
  const query = db.query(sql, (err, result) => {
    //console.log(result);
    if (err){console.error(err);  return res.send({error:err,res:null})};
    res.send({err:null,res:result});
  });
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
