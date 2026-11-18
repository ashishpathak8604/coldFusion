import './App.css';
import { useState } from 'react';
import { useAppDispatch, useAppSelector } from './app/hooks';
import { fetchUsers,fetchUsersById } from './features/users/usersSlice';

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
} = useAppSelector((state) => state.users);

   const [userId, setUserId] = useState("");
   const [showUsers, setShowUsers] = useState(false);

  
     const handleSearch = () => {
      const id = Number(userId);

      if(!userId || !Number.isInteger(id) || id <= 0) {
        return "please enter a valid positive user ID" ;
      }
      dispatch(fetchUsersById(id));
     }
     const handleAllusers = () => {
      dispatch(fetchUsers());
      setShowUsers(true);

     }

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

    <button className="add-button"> + Add User</button>
  {/* diaplay the user by id */}

    <div className="result-section">
      <h3>API Response</h3>
       {selectedUserStatus === "loading" && <p>Loading...</p>}
       {selectedUserStatus === "failed" && <p>{selectedUserError}</p>}
       {selectedUserStatus === "succeeded" && selectedUser && (
        <pre>{JSON.stringify(selectedUser,null,2)}</pre>
       )}
       {selectedUserStatus === "succeeded" && !selectedUser && (
        <p>Enter a user Id to search</p>
       )}
    </div>

    <div className='users-buttons'>
    <button onClick={handleAllusers} >Search All Users</button>
    <button onClick={() => setShowUsers(false)}>Hide Users</button>
      </div>

      {/* display all users */}
     {showUsers && (
      <div className='result-section'>
        <h3> All Users</h3>

        {usersStatus === "loading" && <p>Loading users...</p>}
        {usersStatus === "failed" && <p>{usersError}</p>}
        {usersStatus === "succeeded" && users.length === 0 &&(
          <p>No users found</p>
        )}
        {usersStatus === "succeeded" && users.length > 0 && (
          <ul>
            {users.map((user) => (
              <li key={user.id}>
                {user.name} - {user.email}
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