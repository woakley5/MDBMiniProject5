// DEPENDENCIES
const db = require("../util/db.js");
const fcm = require("../util/fcm.js");

// REF
const ref = db.refs.postRef;
const topic = "new-post";
const newPostMessage = "A new post has been added";

// METHODS
function getAll() {
  return db.getAll(ref);
}

function getById(id) {
  return db.getById(ref, id);
}

function createByAutoId(fieldToVal) {
  return db.createByAutoId(ref, {
    date: fieldToVal.date,
    description: fieldToVal.description,
    latitude: fieldToVal.latitude,
    longitude: fieldToVal.longitude,
    pictureURL: fieldToVal.pictureURL,
    postId: fieldToVal.postId,
    posterId: fieldToVal.posterId
  });
}

function notifyNewPost() {
  db.listenForChanges(ref, function(post) {
    fcm.sendNotification(topic, newPostMessage);
  });
}

// EXPORTS
module.exports.getAll = getAll;
module.exports.getById = getById;
module.exports.createByAutoId = createByAutoId;
module.exports.notifyNewPost = notifyNewPost;
module.exports.ref = ref;
