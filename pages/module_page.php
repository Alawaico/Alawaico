<?php
include '../templates/header.php';
$module_id = $_GET['module_id'];

?>
<div class="container">
    <div id="moduleDetails" class="module-details"></div>
    <div id="moduleSteps" class="module-steps"></div>
    <div class="module-btn">
        <button id="back-btn" class="navbar_menu-btn navbar_menu-btn-default">Back</button>
        <button id="next-btn" class="navbar_menu-btn navbar_menu-btn-default">Next</button>
    </div>

</div>

<?php include '../templates/footer.php'; ?>