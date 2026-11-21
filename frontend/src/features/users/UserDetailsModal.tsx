import type { User,RequestStatus } from "./userTypes";

interface UserDetailsModalProps {
    user: User | null;
    status: RequestStatus;
    error: string | null;
    onClose: () => void;
}

function UserDetailsModal({
    user,
    status,
    error,
    onClose,
}: UserDetailsModalProps) {
    return (
<div className="modal-overlay">
    <div className="modal-box">
        <button className="modal-close" onClick={onClose} >
            X
        </button>
         
         <h2>User Details</h2>

         {status === "loading" && <p>Loading user details...</p>}

         {status === "failed" && (
            <p className="error-message">{error}</p>
         )}

         {status === "succeeded" && user && (
            <div className="user-details">
                <p><strong>ID</strong>{user.id}</p>
                <p><strong>Name:</strong>{user.name}</p>
                <p><strong>Email:</strong> {user.email}</p>
                <p><strong>Age:</strong> {user.age}</p>
                <p><strong>Created At:</strong> {user.created_at}</p>

            </div>
         )}
    </div>

</div>
    );
}

export default UserDetailsModal