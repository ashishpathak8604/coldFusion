import './App.css';
import { useState } from 'react';
import { useAppDispatch, useAppSelector } from './app/hooks';
import { fetchUsers,fetchUsersById,addUser } from './features/users/usersSlice';

function App() {

  const dispatch = useAppDispatch();

  // read users form redux //
 const {
 users,
  selectedUser,
  usersStatus,
  usersError,
  selectedUserStatus,
  selectedUserError,
  createUserStatus,
  createUserError,
  createdUser,
} = useAppSelector((state) => state.users);

   const [userId, setUserId] = useState("");
   const [showUsers, setShowUsers] = useState(false);
   const [name, setName] = useState("");
   const [email, setEmail] = useState("");
   const [age, setAge] = useState("");
   const [showAddForm, setShowAddForm] = useState(false);
  
     const handleSearch = () => {
      const id = Number(userId);

      if(!userId || !Number.isInteger(id) || id <= 0) {
        return "please enter a valid positive user ID" ;
      }
      dispatch(fetchUsersById(id));
     };

     const handleAllusers = () => {
      dispatch(fetchUsers());
      setShowUsers(true);
     };

     const handleCreateUser = () => {
      dispatch(
        addUser({
          name: name,
          email: email,
          age: Number(age),
        }),
      )
        .unwrap()
        .then(() => {
          setName("");
          setEmail("");
          setAge("");
        });
     };

return (
  <div className="container">
    <h1>User Management</h1>
    <p> Search and manage users</p>

    <div className="search-section">
      <input
        type="number"
        placeholder="Enter user ID"
        value={userId}
        onChange={(e) => setUserId(e.target.value)}
      />

      <button onClick={handleSearch}>Search</button>
    </div>
    {/* Add user */}
    <button
      className="add-button"
      type="button"
      onClick={() => setShowAddForm(!showAddForm)}
    >
      {" "}
      + Add User
    </button>

    {showAddForm && (
      <div className="result-section add-user-form">
        <h3>Add New User</h3>

        <input
          type="text"
          placeholder="Enter name"
          value={name}
          onChange={(e) => setName(e.target.value)}
        />

        <input
          type="email"
          placeholder=" Enter email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />

        <input
          type="number"
          placeholder="Enter age"
          value={age}
          onChange={(e) => setAge(e.target.value)}
        />

        <button type="button" onClick={handleCreateUser}
          disabled = {createUserStatus === "loading"}>
          {createUserStatus === "loading" ? "creating..." : "Create User"}
        </button>
      </div>
    )}

    {createUserStatus === "loading" && <p>Creating User...</p>}
    {createUserStatus === "succeeded" && createdUser && (
      <div className="success-message">
        <p>User Created successfully!</p>
        <p>
          ID: {createdUser.id} | Name: {createdUser.name}
        </p>
      </div>
    )}
    {createUserStatus === "failed" && (
      <div className="error-message">{createUserError}</div>
    )}

    {/* diaplay the user by id */}

    <div className="result-section">
      <h3>API Response</h3>
      {selectedUserStatus === "loading" && <p>Loading...</p>}
      {selectedUserStatus === "failed" && <p>{selectedUserError}</p>}
      {selectedUserStatus === "succeeded" && selectedUser && (
        <pre>{JSON.stringify(selectedUser, null, 2)}</pre>
      )}
      {selectedUserStatus === "succeeded" && !selectedUser && (
        <p>Enter a user Id to search</p>
      )}
    </div>

    <div className="users-buttons">
      <button onClick={handleAllusers}>Search All Users</button>
      <button onClick={() => setShowUsers(false)}>Hide Users</button>
    </div>

    {/* display all users */}
    {showUsers && (
      <div className="result-section">
        <h3> All Users</h3>

        {usersStatus === "loading" && <p>Loading users...</p>}
        {usersStatus === "failed" && <p>{usersError}</p>}
        {usersStatus === "succeeded" && users.length === 0 && (
          <p>No users found</p>
        )}
        {usersStatus === "succeeded" && users.length > 0 && (
          <ul>
            {users.map((user) => (
              <li key={user.id}>
                {user.name} - {user.email} - {user.age}
              </li>
            ))}
          </ul>
        )}
      </div>
    )}
  </div>
);

}

export default App;