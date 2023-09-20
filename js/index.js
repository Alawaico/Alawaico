document.addEventListener("DOMContentLoaded", function () {
  const urlParams = new URLSearchParams(window.location.search);
  const page = urlParams.get("page");

  const tutorialDiv = document.getElementById("tutorial");
  const tutorialListDiv = document.getElementById("tutorialList");
  // const moduleListDiv = document.getElementById("modules");
  const moduleListDiv = document.getElementById("moduleList");
  const moduleDetailsDiv = document.getElementById("moduleDetails");
  const moduleStepsDiv = document.getElementById("moduleSteps");

  function getParameterByName(name) {
    const url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    const regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
      results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return "";
    return decodeURIComponent(results[2].replace(/\+/g, " "));
  }

  const tutorialId = getParameterByName("id");

  function fetchTutorialData(id) {
    fetch(`./includes/functions.php?action=getTutorial&tutorial_id=${id}`)
      .then((response) => response.json())
      .then((data) => {
        const tutorial = data.tutorial;
        const steps = data.steps;

        tutorialDiv.innerHTML = `
                    <h1>${tutorial.title}</h1>
                    <p>${tutorial.description}</p>
                `;

        steps.forEach((step) => {
          tutorialDiv.innerHTML += `
                        <h2>Step ${step.step_number}</h2>
                        <p>${step.content}</p>
                    `;
        });
      })
      .catch((error) => console.error("Error:", error));
  }

  function fetchTutorials() {
    fetch("./includes/functions.php?action=getTutorials")
      .then((response) => response.json())
      .then((data) => {
        data.forEach((tutorial) => {
          const tutorialDiv = document.createElement("div");
          tutorialDiv.className = "tutorial";
          tutorialDiv.innerHTML = `
                        <h2>${tutorial.title}</h2>
                        <p>${tutorial.description}</p>
                        <a href="tutorial_list.php?id=${tutorial.id}">Start Tutorial</a>
                    `;
          tutorialListDiv.appendChild(tutorialDiv);
        });
      })
      .catch((error) => console.error("Error:", error));
  }

  let currentStep = 0;
  let stepsData = [];
  let currentQuestion = 0;
  const questionsContainer = document.getElementById("questions-container");
  const form = document.getElementById("quizForm");
  const questions = stepsData; // Assuming stepsData contains quiz questions

  function showCurrentStep(stepNumber) {
    moduleStepsDiv.innerHTML = `
    <div class="module-step">
        <h3>Step ${stepsData[stepNumber].step_number}</h3>
        <p>${stepsData[stepNumber].step_description}</p>
    </div>
  `;
  }

  function showQuestion(index) {
    const question = questions[index];
    questionsContainer.innerHTML = `
              <div class="question">
                  <h2>Question ${index + 1}:</h2>
                  <p>${question.question}</p>
                  <label>
                      <input type="radio" name="q${index + 1}" value="a"> ${
      question.option_a
    }
                  </label>
                  <label>
                      <input type="radio" name="q${index + 1}" value="b"> ${
      question.option_b
    }
                  </label>
                  <label>
                      <input type="radio" name="q${index + 1}" value="c"> ${
      question.option_c
    }
                  </label>
              </div>
    `;
  }

  function updateScore() {
    const selectedOption = form.querySelector(
      `input[name="q${currentQuestion + 1}"]:checked`
    );
    if (selectedOption) {
      if (selectedOption.value === questions[currentQuestion].correct_option) {
        score++;
      }
    }
  }

  function navigate(direction) {
    if (direction === "next" && currentQuestion < questions.length - 1) {
      updateScore();
      currentQuestion++;
      showQuestion(currentQuestion);
    } else if (direction === "prev" && currentQuestion > 0) {
      currentQuestion--;
      showQuestion(currentQuestion);
    }
  }

  function handleProgress() {
    stepsData[currentStep].completed = true;
    progressBtn.disabled = true;
  }

  function handleNext() {
    if (currentStep < stepsData.length - 1) {
      currentStep++;
      showCurrentStep(currentStep);
    }
  }

  function handlePrevious() {
    if (currentStep > 0) {
      currentStep--;
      showCurrentStep(currentStep);
    }
  }

  function fetchModules() {
    fetch("./includes/functions.php?action=getModules")
      .then((response) => response.json())
      .then((data) => {
        data.forEach((module) => {
          const moduleDiv = document.createElement("div");
          moduleDiv.className = "module";
          moduleDiv.innerHTML = `
            <h2>${module.module_name}</h2>
            <p>${module.description}</p>
            <p><span>Learning Objective:</span> ${module.learning_objective}</p>
            <p><span>Duration:</span> ${module.duration} minutes</p>
            <p><span>Progress:</span> ${module.progress}%</p>
            <p><span>Score:</span> ${module.score}/10</p>
            <a href="index.php?page=module&module_id=${module.module_id}" class="navbar_menu-btn navbar_menu-btn-default">Take the Course</a>
          `;
          moduleListDiv.appendChild(moduleDiv);
        });
      })
      .catch((error) => console.error("Error:", error));
  }

  function loginUser(loginForm) {
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    // Add validation (e.g., check if email and password are not empty)
    if (email.trim() === "" || password.trim() === "") {
      alert("Please enter both email and password.");
      return;
    }

    const formData = new FormData(loginForm);

    // Simulate sending login request to server
    fetch("./includes/functions.php?action=login", {
      method: "POST",
      body: formData,
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.success) {
          alert("Login successful"); // Replace with actual redirect or action
          window.location.href = "index.php?page=dashboard";
        } else {
          alert("Login failed. Please check your credentials."); // Show error message
        }
      })
      .catch((error) => console.error("Error:", error));
  }

  function registerUser(registerForm) {
    const fullName = document.getElementById("fullName").value;
    const userName = document.getElementById("userName").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirm_password").value;

    if (
      fullName.trim() === "" ||
      userName.trim() === "" ||
      email.trim() === "" ||
      password.trim() === "" ||
      confirmPassword.trim() === ""
    ) {
      alert("All fields are required!");
      return;
    }

    if (password !== confirmPassword) {
      alert("Passwords do not match!");
      return;
    }

    // Send form data to server
    const formData = new FormData(registerForm);
    console.log(formData);

    fetch("./includes/functions.php?action=register", {
      method: "POST",
      body: formData,
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.success) {
          alert("Registration successful!");
          window.location.href = "index.php?page=login";
        } else {
          alert(data.message);
        }
      })
      .catch((error) => console.error("Error:", error));
  }

  function getModules(module_id) {
    fetch(
      `./includes/functions.php?action=getModuleDetails&module_id=${module_id}`
    )
      .then((response) => response.json())
      .then((data) => {
        const module = data.module;
        moduleDetailsDiv.innerHTML = `
        <div class="module-detials-item">
          <h2>${module.module_name}</h2>
          <p>${module.description}</p>
          <p>Learning Objective: ${module.learning_objective}</p>
          <p>Duration: ${module.duration} minutes</p>
          <p>Progress: ${module.progress}%</p>
        </div>
                `;
      })
      .catch((error) => console.error("Error:", error));

    fetch(
      `./includes/functions.php?action=getModuleSteps&module_id=${module_id}`
    )
      .then((response) => response.json())
      .then((data) => {
        stepsData = data.steps;
        showCurrentStep(currentStep);
      })
      .catch((error) => console.error("Error:", error));
  }

  // Assuming you have a variable `page` that identifies the current page

  switch (page) {
    case "learning":
      fetchModules();
      break;

    case "login":
      // Run code specific to another_page
      const loginForm = document.getElementById("loginForm");
      if (loginForm) {
        loginForm.addEventListener("submit", function (e) {
          e.preventDefault();
          // Add your login code here (e.g., calling loginUser function)
          loginUser(loginForm);
        });
      }

      break;
    case "register":
      // Run code specific to another_page
      const registerForm = document.getElementById("registerForm");

      registerForm.addEventListener("submit", function (event) {
        event.preventDefault();
        registerUser(registerForm);
      });

      break;
    case "module":
      // Run code specific to another_page
      const urlParams = new URLSearchParams(window.location.search);
      const module_id = urlParams.get("module_id");
      const nextBtn = document.getElementById("next-btn");
      const backBtn = document.getElementById("back-btn");

      nextBtn.addEventListener("click", handleNext);
      backBtn.addEventListener("click", handlePrevious);

      getModules(module_id);
      break;
    case "quiz":
      // Run code specific to another_page
      const prevButton = document.getElementById("prev-btn");
      const nextButton = document.getElementById("next-btn");

      form.addEventListener("submit", function (e) {
        e.preventDefault();
        updateScore();
        alert("Quiz completed! Your score is: " + score);
      });
      prevButton.addEventListener("click", function () {
        navigate("prev");
      });

      nextButton.addEventListener("click", function () {
        navigate("next");
      });

      showQuestion(currentQuestion);
      break;

    // Add cases for other pages as needed

    default:
      // Default case, maybe do nothing or show an error
      break;
  }
});
