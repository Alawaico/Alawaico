<?php
include '../templates/header.php';

?>
<header class="header_section">
    <div class="container">
        <div class="section_center">
            <h1>QUIZ</h1>
        </div>
    </div>
</header>
<div class="quiz">

    <div class="container">
        <h1>Quiz Title</h1>
        <form id="quiz-form">
            <div id="questions-container"></div>

            <button type="submit" id="submit-btn">Submit</button>
        </form>
    </div>
</div>

<?php include '../templates/footer.php'; ?>