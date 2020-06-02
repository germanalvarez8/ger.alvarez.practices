import React, { Component } from 'react'
import axios from 'axios'
import DatePicker from 'react-datepicker'
import 'react-datepicker/dist/react-datepicker.css'

export default class CreateNote extends Component {

    state = {
        users: [],
        userSelected: '',
        title: '',
        content: '',
        date: new Date(),
        status: '',
        editing: false,
        _id: ''
    }

    async componentDidMount() {
        const res = await axios.get('http://localhost:4000/api/users')
        this.setState({
            users: res.data.map(user => user.userName),
            userSelected: res.data[0].userName,
        })

        if (this.props.match.params.id) {
            const res = await axios.get('http://localhost:4000/api/notes/' + this.props.match.params.id);
            this.setState({
                title: res.data.title,
                content: res.data.content,
                userSelected: res.data.author,
                date: new Date(res.data.date),
                editing: true,
                status: res.data.status,
                _id: this.props.match.params.id
            })
            //console.log(res.data)
        }
    }
    onSubmit = async (e) => {
        e.preventDefault();
        const newNote = {
            title: this.state.title,
            content: this.state.content,
            date: this.state.date,
            author: this.state.userSelected,
            status: this.state.status
        };
        if (this.state.editing) {
            await axios.put('http://localhost:4000/api/notes/' + this.state._id, newNote);
        } else {
            await axios.post('http://localhost:4000/api/notes', newNote);
        }
        console.log(this.state.date)
        window.location.href = '/'
        
    }

    inputChange = (e) => {
        this.setState({
            [e.target.name]: e.target.value
        })
    }
    onChangeDate = date => {
        this.setState({ date });
    }

    render() {
        return (
            <div className="col-md-6 offset-md-3">

                <div className="card card-body">
                    <h4>Create a Note</h4>

                    {/** SELECT USER */}
                    <div className="form-group">
                        <select
                            className="form-control"
                            name="userSelected"
                            onChange={this.inputChange}
                            value={this.state.userSelected}
                        >
                            {
                                this.state.users.map(user =>
                                    <option key={user} value={user}>
                                        {user}
                                    </option>)
                            }
                        </select>
                    </div>
                    <div className="form-group">
                        <input
                            type="text"
                            className="form-control"
                            placeholder="Title"
                            name="title"
                            onChange={this.inputChange}
                            value={this.state.title}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <textarea
                            name="content"
                            className="form-control"
                            placeholder="Content"
                            onChange={this.inputChange}
                            value={this.state.content}
                            required
                        >
                        </textarea>
                    </div>
                    <div className="form-group">
                        <DatePicker
                            className="form-control"
                            selected={this.state.date}
                            onChange={this.onChangeDate}
                        />
                    </div>
                    <div className="form-group">
                        <select name="status"
                            className="form-control"
                            id="sel1"
                            placeholder="Status"
                            onChange={this.inputChange}
                            value={this.state.status}>
                            <option>Open</option>
                            <option>In Progress</option>
                            <option>Canceled</option>
                            <option>Resolved</option>
                        </select>
                    </div>
                    <form onSubmit={this.onSubmit}>
                        <button type="submit" className="btn btn-primary">
                            Save Note
                        </button>
                    </form>
                </div>
            </div>
        )
    }
}
