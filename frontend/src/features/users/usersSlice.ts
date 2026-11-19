import { createSlice,createAsyncThunk } from "@reduxjs/toolkit";
import { createUser, getAllUsers,getUserById } from "./usersAPI";
import type {User, RequestStatus,CreateUser} from "./userTypes";
import { act } from "react";

//fetch all users form the backend //
export const fetchUsers = createAsyncThunk<
User[],
void,
{ rejectValue: string}
>(
    "users/fetchUsers",
    async (_, { rejectWithValue }) => {
        const response = await getAllUsers();

        if (!response.success) {
            return rejectWithValue(response.message);
        }
        
          return response.data;
    }
);

// fetching users by there ID//
export const fetchUsersById = createAsyncThunk<
User,
number,
{ rejectValue : string}
>(
    "users/fetchUserById",
    async (id, { rejectWithValue }) => {
        const response = await getUserById(id);

        if(!response.success){
            return rejectWithValue(response.message);
        }
        return response.data;
    }
); 

// POST data to the backend//
export const addUser = createAsyncThunk<
User,
CreateUser,
{ rejectValue: string}
>(
    "users/addUser",
    async (userData, { rejectWithValue }) => {
        const response = await createUser(userData);

        if(!response.success) {
            return rejectWithValue(response.message)
        }
        return response.data;
    }
)
// Describes all the user-related data we want to manage.//
interface UsersState {
    users: User[];
    selectedUser: User | null;
    createdUser: User | null;
  
    createUserStatus: RequestStatus;
    createUserError: string | null;

    usersStatus: RequestStatus;
    usersError: string | null;

    selectedUserStatus: RequestStatus;
    selectedUserError: string | null;

}
// Initial state when the application starts.//
const initialState: UsersState = {
    users: [],
    selectedUser: null,
    createdUser: null,

    createUserStatus: "idle",
    usersStatus: "idle",
    usersError: null,

    createUserError: null,
    selectedUserStatus: "idle",
    selectedUserError: null,
};
// create the user slice.//

const usersSlice = createSlice({
  name: "users",
  initialState,
  reducers: {},

  // handle the diffrent action created during api request //
  extraReducers: (builder) => {
    builder
      // run when the api request starts //
      .addCase(fetchUsers.pending, (state) => {
        state.usersStatus = "loading";
        state.usersError = null;
      })
      // runs when the api request is success//
      .addCase(fetchUsers.fulfilled, (state, action) => {
        state.usersStatus = "succeeded";
        state.users = action.payload;
      })

      // runs when the API request fails //
      .addCase(fetchUsers.rejected, (state, action) => {
        state.usersStatus = "failed";
        state.usersError =
          action.payload ?? action.error.message ?? "Something went wrong";
      })

      .addCase(fetchUsersById.pending, (state) => {
        state.selectedUserStatus = "loading";
        state.selectedUserError = null;
        state.selectedUser = null;
      })

      .addCase(fetchUsersById.fulfilled, (state, action) => {
        state.selectedUserStatus = "succeeded";
        state.selectedUser = action.payload;
      })

      .addCase(fetchUsersById.rejected, (state, action) => {
        state.selectedUserStatus = "failed";
        state.selectedUserError =
          action.payload ?? action.error.message ?? "Something went wrong";
        state.selectedUser = null;
      })

      // Add a new user
      .addCase(addUser.pending, (state) => {
        state.createUserStatus = "loading";
        state.createUserError = null;
        state.createdUser = null;
      })

      .addCase(addUser.fulfilled, (state, action) => {
        state.createUserStatus = "succeeded";
        state.createdUser = action.payload;
      })

      .addCase(addUser.rejected, (state, action) => {
        state.createUserStatus = "failed";
        state.createUserError =
          action.payload ?? action.error.message ?? "Something went wrong";
      });
  },
});

export default usersSlice.reducer;