<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'db.php';
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'POST') {
    $data = json_decode(file_get_contents("php://input"));
    if (!empty($data->room_id) && !empty($data->customer_name) && !empty($data->email) && !empty($data->phone) && !empty($data->check_in) && !empty($data->check_out) && !empty($data->guests) && !empty($data->total_amount)) {
        
        $room_id = $conn->real_escape_string($data->room_id);
        $customer = $conn->real_escape_string($data->customer_name);
        $email = $conn->real_escape_string($data->email);
        $phone = $conn->real_escape_string($data->phone);
        $check_in = $conn->real_escape_string($data->check_in);
        $check_out = $conn->real_escape_string($data->check_out);
        $guests = $conn->real_escape_string($data->guests);
        $total = $conn->real_escape_string($data->total_amount);

        $sql = "INSERT INTO bookings (room_id, customer_name, email, phone, check_in, check_out, guests, total_amount) VALUES ('$room_id', '$customer', '$email', '$phone', '$check_in', '$check_out', '$guests', '$total')";
        
        if ($conn->query($sql) === TRUE) {
            http_response_code(201);
            echo json_encode(["message" => "Booking saved successfully."]);
        } else {
            http_response_code(500);
            echo json_encode(["message" => "Unable to save booking."]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["message" => "Incomplete data."]);
    }
}
elseif ($method === 'GET') {
    if (isset($_GET['id'])) {
        $id = $conn->real_escape_string($_GET['id']);
        $sql = "SELECT * FROM bookings WHERE id = $id";
    } else {
        $sql = "SELECT * FROM bookings";
    }
    
    $result = $conn->query($sql);
    if ($result) {
        $bookings = array();
        while ($row = $result->fetch_assoc()) {
            $bookings[] = $row;
        }
        http_response_code(200);
        echo json_encode(isset($_GET['id']) && count($bookings) > 0 ? $bookings[0] : $bookings);
    } else {
        http_response_code(500);
        echo json_encode(["message" => "Database query failed."]);
    }
}
elseif ($method === 'PUT') {
    $data = json_decode(file_get_contents("php://input"));
    $id = isset($_GET['id']) ? $conn->real_escape_string($_GET['id']) : null;
    
    if ($id && isset($data->status)) {
        $status = $conn->real_escape_string($data->status);
        $sql = "UPDATE bookings SET status='$status' WHERE id=$id";
        
        if ($conn->query($sql) === TRUE) {
            http_response_code(200);
            echo json_encode(["message" => "Booking status updated successfully."]);
        } else {
            http_response_code(500);
            echo json_encode(["message" => "Failed to update booking status."]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["message" => "Booking ID and new status are required."]);
    }
} else {
    http_response_code(405);
    echo json_encode(["message" => "Method not allowed."]);
}
$conn->close();
?>