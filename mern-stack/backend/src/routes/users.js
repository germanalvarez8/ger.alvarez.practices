const {Router} = require('express');
const router = Router();
const {getUsers, createUser, deleteUser} = require('../controllers/users_controller');
router.route('/')
    .get(getUsers)
    .post(createUser)
 
router.route('/:id')
    .delete(deleteUser)    

module.exports = router;
