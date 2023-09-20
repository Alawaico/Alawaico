<?php session_start() ?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="styles/styles.css">
</head>

<body>
    <?php if ($_GET['page'] !== "login" && $_GET['page'] !== "register") : ?>

        <nav class="navbar">
            <div class="container">
                <div class="d-flex justify-content-between">
                    <ul class="navbar_menu">
                        <li class="navbar_menu-item"><a href="index.php?page=home" class="navbar_menu-link">Home</a></li>
                        <li class="navbar_menu-item"><a href="index.php?page=quiz" class="navbar_menu-link">Quiz</a></li>
                        <li class="navbar_menu-item"><a href="index.php?page=learning" class="navbar_menu-link">Learning</a></li>
                        <li class="navbar_menu-item"><a href="index.php?page=resource" class="navbar_menu-link">Resource</a></li>
                        <li class="navbar_menu-item"><a href="index.php?page=feedback" class="navbar_menu-link">Feedback</a></li>
                    </ul>
                    <div class="">
                        <ul class="navbar_menu">
                            <?php if (isset($_SESSION['email'])) : ?>
                                <li class="navbar_menu-item"><a href="index.php?page=dashboard" class="navbar_menu-btn navbar_menu-btn-default">Dashboard</a></li>
                                <li class="navbar_menu-item"><a href="index.php?page=logout" class="navbar_menu-btn navbar_menu-btn-outline">Logout</a></li>
                            <?php else : ?>
                                <li class="navbar_menu-item"><a href="index.php?page=login" class="navbar_menu-btn navbar_menu-btn-default">Login</a></li>
                                <li class="navbar_menu-item"><a href="index.php?page=register" class="navbar_menu-btn navbar_menu-btn-outline">Register</a></li>
                            <?php endif; ?>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

    <?php endif ?>