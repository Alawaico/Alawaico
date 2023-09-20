<?php
include('db.php');

function getTutorial($tutorial_id)
{
    global $conn;

    $data = array();

    $sql = "SELECT * FROM tutorials WHERE id = $tutorial_id";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $data['tutorial'] = $row;
        }
        $sql_steps = "SELECT * FROM tutorial_steps WHERE tutorial_id = $tutorial_id";
        $result_steps = $conn->query($sql_steps);
        if ($result_steps->num_rows > 0) {
            while ($row = $result_steps->fetch_assoc()) {
                $data['steps'][] = $row;
            }
        }
    }
    $result = $conn->query($sql);

    if (!$result) {
        die("Error: " . $conn->error);
    }

    // Continue with processing the result

    return $data;
}

function displayTutorial($tutorial_id)
{
    $data = getTutorial($tutorial_id);

    if (isset($data['tutorial']) && isset($data['steps'])) {
        $tutorial = $data['tutorial'];
        $steps = $data['steps'];

        echo "
            <h1>{$tutorial['title']}</h1>
            <p>{$tutorial['description']}</p>
        ";

        foreach ($steps as $step) {
            echo "
                <h2>Step {$step['step_number']}</h2>
                <p>{$step['content']}</p>
            ";
        }
    } else {
        echo "Tutorial not found.";
    }
}
function getTutorials()
{
    global $conn;

    $sql = "SELECT * FROM tutorials";
    $result = $conn->query($sql);

    $tutorials = [];

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $tutorials[] = $row;
        }
    }

    return $tutorials;
}
function getModules()
{
    global $conn;

    $sql = "SELECT * FROM social_engineering_modules";
    $result = $conn->query($sql);

    $modules = [];

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $modules[] = $row;
        }
    }

    return $modules;
}

function loginUser($email, $password)
{
    global $conn;

    $email = mysqli_real_escape_string($conn, $email);

    // Hash the entered password before querying the database

    $sql = "SELECT * FROM users WHERE email = '$email'";
    $result = $conn->query($sql);

    if ($result->num_rows == 1) {
        $row = $result->fetch_assoc();
        $hashedStoredPassword = $row['password'];
        $role = $row['role'];

        // Verify the hashed password
        if (password_verify($password, $hashedStoredPassword)) {
            // Password is correct, perform further actions (e.g., set session)
            session_start();
            $_SESSION['email'] = $email;
            $_SESSION['user_role'] = $role;
            return ['success' => true];
        }
    }

    return ['success' => false, 'message' => 'Invalid email or password'];
}


function registerUser($fullName, $userName, $email, $password)
{
    global $conn;

    $fullName = mysqli_real_escape_string($conn, $fullName);
    $userName = mysqli_real_escape_string($conn, $userName);
    $email = mysqli_real_escape_string($conn, $email);
    $password = mysqli_real_escape_string($conn, $password);
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    $sql = "INSERT INTO users (name, username, email, password, role) VALUES ('$fullName', '$userName', '$email', '$hashedPassword','user')";

    if ($conn->query($sql) === TRUE) {
        return ['success' => true];
    } else {
        return ['success' => false, 'message' => $conn->error];
    }
}

function getModuleDetails($module_id)
{
    global $conn;

    $module_id = mysqli_real_escape_string($conn, $module_id);

    $sql = "SELECT * FROM social_engineering_modules WHERE module_id = $module_id";
    $result = $conn->query($sql);

    if ($result->num_rows == 1) {
        $module = $result->fetch_assoc();
        return $module;
    } else {
        return null;
    }
}


function getModuleSteps($module_id)
{
    global $conn;

    $module_id = mysqli_real_escape_string($conn, $module_id);

    $sql = "SELECT s.*, si.image_data 
            FROM steps s 
            LEFT JOIN step_images si ON s.step_id = si.step_id 
            WHERE s.module_id = $module_id 
            ORDER BY s.step_number";

    $result = $conn->query($sql);

    $steps = [];

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $steps[] = $row;
        }
    }

    return $steps;
}

function getQuizQuestions()
{
    global $conn;

    $sql = "SELECT * FROM quiz_questions";
    $result = $conn->query($sql);

    $questions = [];

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $questions[] = $row;
        }
    }

    return $questions;
}








if (isset($_GET['action'])) {
    switch ($_GET['action']) {
        case 'getTutorial':
            if (isset($_GET['tutorial_id'])) {
                $tutorial_id = $_GET['tutorial_id'];
                $data = getTutorial($tutorial_id);
                echo json_encode($data);
            } else {
                echo json_encode(['error' => 'Tutorial ID not provided']);
            }
            break;

        case 'getTutorials':
            $tutorials = getTutorials();
            echo json_encode($tutorials);
            break;
        case 'getModules':
            $tutorials = getModules();
            echo json_encode($tutorials);
            break;
        case 'login':
            if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['email']) && isset($_POST['password'])) {
                $email = $_POST['email'];
                $password = $_POST['password'];

                $result = loginUser($email, $password);
                echo json_encode($result);
            } else {
                echo json_encode(['success' => false, 'message' => 'Invalid request']);
            }
            break;

        case 'register':
            if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['fullName']) && isset($_POST['userName']) && isset($_POST['email']) && isset($_POST['password']) && isset($_POST['confirm_password'])) {
                $fullName = $_POST['fullName'];
                $userName = $_POST['userName'];
                $email = $_POST['email'];
                $password = $_POST['password'];


                $registerResult = registerUser($fullName, $userName, $email, $password);

                echo json_encode($registerResult);
            } else {
                echo json_encode(['success' => false, 'message' => 'Invalid request']);
            }
            break;
        case 'getModuleDetails':
            if (isset($_GET['action']) && $_GET['action'] === 'getModuleDetails') {
                if (isset($_GET['module_id'])) {
                    $module_id = $_GET['module_id'];
                    $module = getModuleDetails($module_id);
                    if ($module) {
                        echo json_encode(['module' => $module]);
                    } else {
                        echo json_encode(['error' => 'Module not found']);
                    }
                } else {
                    echo json_encode(['error' => 'Module ID not provided']);
                }
            }
            break;
        case 'getModuleSteps':
            // Usage:
            if (isset($_GET['action']) && $_GET['action'] === 'getModuleSteps') {
                if (isset($_GET['module_id'])) {
                    $module_id = $_GET['module_id'];
                    $steps = getModuleSteps($module_id);
                    echo json_encode(['steps' => $steps]);
                } else {
                    echo json_encode(['error' => 'Module ID not provided']);
                }
            }
            break;

        default:
            echo json_encode(['error' => 'Invalid action']);
            break;
    }
}


$conn->close();
