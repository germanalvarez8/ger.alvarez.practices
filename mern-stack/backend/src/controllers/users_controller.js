const userCtrl = {};

const User = require('../models/User');

userCtrl.getUsers = async (req,res)=> {
    const user = await User.find();
    res.json(user)
}
userCtrl.createUser = async (req,res)=> {
    const {userName} = req.body;
    const newUser = new User({userName})
    await newUser.save();
    res.json('user Created')
}
userCtrl.deleteUser = async (req,res)=> {
    await User.findByIdAndDelete(req.params.id)
    res.json('User deleted');
}

module.exports = userCtrl;