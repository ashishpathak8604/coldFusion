import type { ApiResponse,User } from "./userTypes";

// Base URL coming form .env//
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;
 // fetching all users from backend //
export async function getAllUsers(): Promise<ApiResponse<User[]>> {
    const response = await fetch(`${API_BASE_URL}/users`);

    const result: ApiResponse<User[]> = await response.json();

    return result;
}

// fetching the user by ID//
export async function getUserById (
    id: number
): Promise<ApiResponse<User>> {
    const response = await fetch(`${API_BASE_URL}/users/${id}`);

    const result: ApiResponse<User> = await response.json();

    return result
}