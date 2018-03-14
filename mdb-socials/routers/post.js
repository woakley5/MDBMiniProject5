// DEPENDENCIES
const router = require("express").Router();
const completeRequest = require("../util/routing.js").completeRequest;
const postLogic = require("../logic/post.js");
const userRef = require("../logic/user.js").ref;

// ROUTES
router.get("/Posts", function(req, res) {
  completeRequest(req, res, postLogic.getAll);
});

router.get("/Posts/:id", function(req, res) {
  req.checkParams("id", "no id present").notEmpty();
  req.checkParams("id", "post id does not exist").isValidId(postLogic.ref);
  completeRequest(req, res, function(params) {
    console.log(params.id)
    return postLogic.getById(params.id);
  });
});

router.post("/Posts/", function(req, res) {
  console.log("Making a new post!");
  req.checkBody("date", "no fullname present").notEmpty();
  req.checkBody("description", "no email present").notEmpty();
  req.checkBody("latitude", "no profPicUrl present").notEmpty();
  req.checkBody("longitude", "no userID present").notEmpty();
  req.checkBody("pictureURL", "no username present").notEmpty();
  req.checkBody("postId", "no username present").notEmpty();
  req.checkBody("posterId", "no username present").notEmpty();
  completeRequest(req, res, function(params) {
    console.log(params)
    return postLogic.createByAutoId(params)
  });
});

// EXPORTS
module.exports = router;
