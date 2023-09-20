<?php

function sanitizeInput($input)
{
    return htmlspecialchars(trim($input));
}
function includePage($page, $childRoute = null)
{
    $page = sanitizeInput($page);
    $childRoute = sanitizeInput($childRoute);

    if ($childRoute) {
        include_once "../pages/{$page}/{$childRoute}_page.php";
    } else {
        include_once "../pages/{$page}_page.php";
    }
}

if (isset($_GET['page'])) {
    $page = $_GET['page'];
    $childRoute = isset($_GET['child_route']) ? $_GET['child_route'] : null;
    includePage($page, $childRoute);
} else {
    includePage('home');
}


if (isset($_GET['page'])) {
    includePage($_GET['page']);
} else {
    includePage('home');
}
