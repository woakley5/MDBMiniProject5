// DEPENDENCIES
const db = require("../util/db.js");

// REF
const ref = db.refs.userRef;

// METHODS
function getById(id) {
  return db.getById(ref, id);
}

function createByAutoId(fieldToVal) {
  return db.createByAutoId(ref, {
    name: fieldToVal.name,
    email: fieldToVal.email,
    profilePictureURL: fieldToVal.profilePictureURL,
    userID: fieldToVal.userID,
    username: fieldToVal.username
  });
}

function favorite(id, favId) {
  return db.transaction(ref, id, "favoriteIds", function(favoriteIds) {
    favoriteIds = favoriteIds || [];
    favoriteIds.push(favId);
    return favoriteIds;
  });
}

// EXPORTS
module.exports.getById = getById;
module.exports.createByAutoId = createByAutoId;
module.exports.ref = ref;
