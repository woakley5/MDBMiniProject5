// DEPENDENCIES
const firebase = require("firebase-admin");

// INITIALIZE
var serviceAccount = require('../mdbsocials-97392-firebase-adminsdk-qw4za-77a712982e.json');

firebase.initializeApp({
  credential: firebase.credential.cert(serviceAccount),
  databaseURL: 'https://mdbsocials-97392.firebaseio.com'
});

// EXPORTS
module.exports = firebase;
