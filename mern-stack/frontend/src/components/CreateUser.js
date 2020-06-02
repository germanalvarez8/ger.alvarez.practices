import React, { Component } from 'react'
import axios from 'axios'

export default class CreateUser extends Component {

    state = {
        users: [],
        userName:'' 
    }
    async componentDidMount() {
        this.getUsers();
        //console.log(this.state.users)
    }
     getUsers = async ()=>{
        const res = await axios.get('http://localhost:4000/api/users');
        this.setState({ users: res.data })

    }
    onChangeUserName = (e) => {
        this.setState({
            userName: e.target.value
        })
    }
    
    onSubmit = async e => {
        e.preventDefault();  //Cancela el refresh de la pagina al darle a Save
            await axios.post('http://localhost:4000/api/users', {
            userName: this.state.userName
        })
        this.setState({userName:''})
        this.getUsers();
    }

    deleteUser = async (id) =>{
        await axios.delete('http://localhost:4000/api/users/' + id)
        this.getUsers();
    }

    render() {
        return (
            <div className="row">
                <div className="col-md-4">
                    <div className="card card-body">
                        <h3> Create New User</h3>
                        <form onSubmit={this.onSubmit} >
                            <div className="form-group">
                                <input type="text" 
                                className="form-control" 
                                value={this.state.userName}
                                onChange={this.onChangeUserName} 
                                />
                            </div>
                            <button type="submit" className="btn btn-primary">
                                Save
                            </button>
                        </form>
                    </div>
                </div>
                <div className="col-md-8">
                    <ul className="list-group list-group-flush">
                        {
                            this.state.users.map(user => (
                                <li 
                                    className="list-group-item list-group-item-action" 
                                    key={user._id}
                                    onDoubleClick={() => this.deleteUser(user._id)}
                                    >
                                    {user.userName }
                                </li>))
                        }
                    </ul>
                </div>
            </div>
        )
    }
}
