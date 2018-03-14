// DEPENDENCIES
const router = require("express").Router();
const completeRequest = require("../util/routing.js").completeRequest;
const userLogic = require("../logic/user.js");
const postRef = require("../logic/post.js").ref;

// ROUTES
router.get("/User/:id", function(req, res) {
  completeRequest(req, res, function(params) {
    return userLogic.getById(params.id);
  });
});

router.post("/User/", function(req, res) {
  req.checkBody("name", "no fullname present").notEmpty();
  req.checkBody("email", "no email present").notEmpty();
  req.checkBody("profilePictureURL", "no profPicUrl present").notEmpty();
  req.checkBody("userID", "no userID present").notEmpty();
  req.checkBody("username", "no username present").notEmpty();
  completeRequest(req, res, function(params) {
    console.log(params)
    return userLogic.createByAutoId(params)
  });
});

router.patch("/User/:id/favorites", function(req, res) {
  req.checkParams("id", "no id present").notEmpty();
  req.checkParams("id", "user id does not exist").isValidId(userLogic.ref);
  req.checkBody("postId", "no postId present").notEmpty();
  req.checkBody("postId", "post id does not exist").isValidId(postRef);
  var fn;
  if (req.body.favorite) {
    fn = userLogic.favorite;
  } else {
    fn = userLogic.unFavorite;
  }
  completeRequest(req, res, function(params) {
    return fn(req.params.id, req.body.postId);
  });
});

// EXPORTS
module.exports = router;
