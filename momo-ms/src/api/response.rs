// API response model
pub struct ApiResponse<T> {
    success: bool,
    payload: T,
    message: String,
}
