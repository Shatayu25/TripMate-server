<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'db.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    if (isset($_GET['id'])) {
        $id = $conn->real_escape_string($_GET['id']);
        $sql = "SELECT * FROM rooms WHERE id = $id";
    } else {
        $sql = "SELECT * FROM rooms";
    }
    $result = $conn->query($sql);
    if ($result) {
        $rooms = array();
        while ($row = $result->fetch_assoc()) {
            $row['id'] = (int)$row['id'];
            $row['price_per_night'] = (float)$row['price_per_night'];
            $row['max_guests'] = (int)$row['max_guests'];
            $rooms[] = $row;
        }
        http_response_code(200);
        echo json_encode(isset($_GET['id']) && count($rooms) > 0 ? $rooms[0] : $rooms);
    } else {
        http_response_code(500);
        echo json_encode(["message" => "Database query failed."]);
    }
} 
elseif ($method === 'POST') {
    $data = json_decode(file_get_contents("php://input"));
    if (!empty($data->room_number) && !empty($data->room_type) && !empty($data->price_per_night) && !empty($data->max_guests)) {
        $room_number = $conn->real_escape_string($data->room_number);
        $room_type = $conn->real_escape_string($data->room_type);
        $description = isset($data->description) ? $conn->real_escape_string($data->description) : '';
        $price = $conn->real_escape_string($data->price_per_night);
        $guests = $conn->real_escape_string($data->max_guests);
        $image = isset($data->image) ? $conn->real_escape_string($data->image) : '';
        $status = isset($data->status) ? $conn->real_escape_string($data->status) : 'Available';

        $sql = "INSERT INTO rooms (room_number, room_type, description, price_per_night, max_guests, image, status) VALUES ('$room_number', '$room_type', '$description', '$price', '$guests', '$image', '$status')";
        
        if ($conn->query($sql) === TRUE) {
            http_response_code(201);
            echo json_encode(["message" => "Room added successfully."]);
        } else {
            http_response_code(500);
            echo json_encode(["message" => "Failed to add room."]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["message" => "Incomplete room data."]);
    }
} 
elseif ($method === 'PUT') {
    $data = json_decode(file_get_contents("php://input"));
    $id = isset($_GET['id']) ? $conn->real_escape_string($_GET['id']) : null;
    
    if ($id && $data) {
        $updates = [];
        if (isset($data->room_number)) $updates[] = "room_number='" . $conn->real_escape_string($data->room_number) . "'";
        if (isset($data->room_type)) $updates[] = "room_type='" . $conn->real_escape_string($data->room_type) . "'";
        if (isset($data->description)) $updates[] = "description='" . $conn->real_escape_string($data->description) . "'";
        if (isset($data->price_per_night)) $updates[] = "price_per_night='" . $conn->real_escape_string($data->price_per_night) . "'";
        if (isset($data->max_guests)) $updates[] = "max_guests='" . $conn->real_escape_string($data->max_guests) . "'";
        if (isset($data->status)) $updates[] = "status='" . $conn->real_escape_string($data->status) . "'";

        $sql = "UPDATE rooms SET " . implode(", ", $updates) . " WHERE id=$id";
        if ($conn->query($sql) === TRUE) {
            http_response_code(200);
            echo json_encode(["message" => "Room updated successfully."]);
        } else {
            http_response_code(500);
            echo json_encode(["message" => "Failed to update room."]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["message" => "Room ID and data are required."]);
    }
}
elseif ($method === 'DELETE') {
    $id = isset($_GET['id']) ? $conn->real_escape_string($_GET['id']) : null;
    if ($id) {
        $sql = "DELETE FROM rooms WHERE id=$id";
        if ($conn->query($sql) === TRUE) {
            http_response_code(200);
            echo json_encode(["message" => "Room deleted successfully."]);
        } else {
            http_response_code(500);
            echo json_encode(["message" => "Failed to delete room."]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["message" => "Room ID is required."]);
    }
} else {
    http_response_code(405);
    echo json_encode(["message" => "Method not allowed."]);
}
$conn->close();
?>