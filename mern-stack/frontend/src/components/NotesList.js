import React, { Component } from 'react'
import axios from "axios";
import { format } from "timeago.js";
import { Link } from 'react-router-dom'
import DatePicker from 'react-datepicker'


var _ = require("underscore");
const status = ["All", "Open", "In Process", "Canceled", "Resolved"]
export default class NotesList extends Component {

    state = {
        notes: [],
        users: [],
        title: '',
        status: '',
        author: '',
        dateFrom: new Date(),
        dateTo: new Date()
    }
    async componentDidMount() {
        this.getNotes();
        const res = await axios.get('http://localhost:4000/api/users')
        this.setState({
            users: res.data.map(user => user.userName),
        })
    }
    async filter(name, value) {
        const res = await axios.get('http://localhost:4000/api/notes')
        var i = 0
        var notesList = [] //_.where(res.data,{title:this.state.title, author:this.state.author, status: this.state.status})
        _.forEach(res.data, function () {
            if ((_.values(res.data[i])).includes(value)) {
                //console.log(res.data[i]);
                notesList.push(res.data[i])
            }
            i++
        });
        this.setState({ notes: notesList })
    }
    inputChange = (e) => {
        this.setState({
            [e.target.name]: e.target.value
        })
        if (e.target.value === status[0] || e.target.value === '') {
            this.getNotes()
        } else { this.filter(e.target.name, e.target.value) }
    }
    async getNotes() {
        const res = await axios.get('http://localhost:4000/api/notes')
        this.setState({ notes: res.data, title: '', author: "All", status: status[0] })
    }
    async getUsers() {
        const res = await axios.get('http://localhost:4000/api/users')
        this.setState({ users: res.data.map(user => user.userName) })
    }
    deleteNote = async (id) => {
        await axios.delete('http://localhost:4000/api/notes/' + id);
        this.getNotes();
    }
    onChangeDateFrom = date => {
        this.setState({ dateFrom: date });
    }
    onChangeDateTo = date => {
        this.setState({ dateTo: date });
    }

    render() {

        return (

            <div className="window">
                <link href="css/bootstrap.min.css" rel="stylesheet" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
                <nav className="navbar navbar-expand-lg navbar-secondary bg-secondary" style={{ height: 50 }}>
                    <div className="container">
                        <div className="row">
                            <div className="col" style={{ marginLeft: -20 }}>
                                <input
                                    type="text"
                                    className="form-control"
                                    placeholder="Title"
                                    name="title"
                                    data-toggle="tooltip"
                                    data-placement="top"

                                    title="Find by title"
                                    value={this.state.title}
                                    onChange={this.inputChange}
                                />
                            </div>
                            <div className="col">
                                <select
                                    className="form-control"
                                    name="author"
                                    data-toggle="tooltip"
                                    data-placement="top"
                                    title="Find by author"
                                    onChange={this.inputChange}
                                    value={this.state.author}
                                >
                                    <option>All</option>
                                    {
                                        this.state.users.map(user =>
                                            <option key={user} value={user}>
                                                {user}
                                            </option>)
                                    }
                                </select>
                            </div>
                            <div className="col">
                                <select name="status"
                                    className="form-control"
                                    data-toggle="tooltip"
                                    data-placement="top"
                                    title="Find by status"
                                    onChange={this.inputChange}
                                    value={this.state.status}>
                                    {
                                        status.map(status =>
                                            <option key={status} value={status}>
                                                {status}
                                            </option>)
                                    }
                                </select>
                            </div>
                            <div className="col">
                                <DatePicker
                                    className="form-control"
                                    data-toggle="tooltip"
                                    data-placement="top"
                                    title="Date From"
                                    selected={this.state.dateFrom}
                                    onChange={this.onChangeDateFrom}
                                />
                            </div>
                            <div className="col">
                                <DatePicker
                                    className="form-control"
                                    data-toggle="tooltip"
                                    data-placement="top"
                                    title="Date To"
                                    selected={this.state.dateTo}
                                    onChange={this.onChangeDateTo}
                                />
                            </div>
                            <div className="col-1">
                                <button
                                    className="btn1 btn-danger"
                                    onClick={() => this.getNotes()}><i className="fa fa-close"></i></button>
                            </div>
                        </div>
                    </div>
                </nav>
                <div className="row">
                    { 
                        this.state.notes.map(note => (
                            <div className="col-md-4 p-2" key={note._id}>
                                <div className="card">
                                    <div className="card-header d-flex justify-content-between">
                                        <h5>{note.title}</h5>
                                        <div className="font-italic">
                                            <h5>{"(" + note.status + ")"}</h5>
                                        </div>
                                    </div>
                                    <div className="card-body">
                                        <p>{note.content}</p>
                                        <p>{note.author}</p>
                                        <p>{format(note.date)}</p>
                                    </div>
                                    <div className="card-footer">
                                        <Link className="btn btn-success" to={"/edit/" + note._id}>
                                            Edit
                                        </Link>
                                        <button className="btn btn-danger" style={{ marginLeft: 190 }} onClick={() => this.deleteNote(note._id)}>
                                            Delete
                                </button>
                                    </div>
                                </div>
                            </div>
                        ))
                    }
                </div>
            </div>
        )
    }
}
