const notesCtrl = {};

const Note = require('../models/Note');

notesCtrl.getNotes = async (req,res)=> {
    const allNotes = await Note.find();  
    res.json(allNotes)
}
notesCtrl.createNote = async (req, res) => {
    //console.log(req.body);
    const{title, content, date, author, status} = req.body;
    const newNote = new Note({
        title,
        content,
        date,
        author,
        status
    })
    await newNote.save();
    res.json({message: 'Note saved'})
};

notesCtrl.getNote = async (req,res)=> {
    const note = await Note.findById(req.params.id);
    res.json(note)
}
notesCtrl.updateNote = async (req,res)=> {
    const {title, content, author, status} = req.body
    await Note.findOneAndUpdate({_id : req.params.id},{
        title,
        content,
        author,
        status
    })
    res.json({message:'Note Updated'})
}
notesCtrl.deleteNote = async (req,res)=> {
    await Note.findByIdAndDelete(req.params.id);
    res.json({message:'Note deleted'})
}

module.exports = notesCtrl;
