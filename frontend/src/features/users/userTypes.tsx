// its a blueprint for a single user coming from our backend //
export interface User {
    id: number;
    name: string;
    email: string;
    age: number;
    created_at: string;
}
// T is a placeholder for waht  response we aer geeting form backend s single user or user[] //
export interface ApiResponse<T> {
    success: boolean;
    statusCode: number;
    message: string;
    data: T;
}

// we are creating the states of API response //
export type RequestStatus = 
| "idle"
| "loading"
| "succeeded"
| "failed";