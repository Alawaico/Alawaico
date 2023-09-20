<?php


// session_start(); // Start session (if not already started)



// Include header and other common dashboard elements
include_once "../templates/header.php"; // Adjust the path as per your project structure
$user_role = isset($_SESSION['user_role']) ? $_SESSION['user_role'] : ''; // Get user role
// Check if user is logged in
if (!isset($_SESSION['email'])) {
    header("Location: index.php?page=login"); // Redirect to login if not logged in
    exit();
}

// Display admin dashboard if user is an admin
if ($user_role === 'admin') {
    include_once "../templates/admin_dashboard_content.php"; // Adjust the path as per your project structure
} else {
    include_once "../templates/user_dashboard_content.php"; // Include user dashboard content
}

// Include footer and other common dashboard elements
include_once "../templates/footer.php"; // Adjust the path as per your project structure
