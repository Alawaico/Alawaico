-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 21, 2023 at 01:37 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `user_awareness_training`
--

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `question_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `option_a` varchar(255) NOT NULL,
  `option_b` varchar(255) NOT NULL,
  `option_c` varchar(255) NOT NULL,
  `option_d` varchar(255) NOT NULL,
  `correct_option` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_questions`
--

INSERT INTO `quiz_questions` (`question_id`, `question_text`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_option`) VALUES
(1, 'Which social engineering technique involves sending a deceptive WhatsApp message that appears to come from a legitimate source like a bank, prompting users to click on a link to a fake website?', 'a) Pretexting', 'b) Spoofing', 'c) Baiting', 'd) Phishing', 'd'),
(2, 'Which technique involves an attacker calling or emailing a victim, pretending to be a government official to extract personal information?', 'a) Phishing', 'b) Baiting', 'c) Pretexting', 'd) Impersonation', 'c'),
(3, 'In which social engineering technique might an attacker offer a WhatsApp user a job opportunity to get them to download malware?', 'a) Spoofing', 'b) Baiting', 'c) Phishing', 'd) Impersonation', 'b'),
(4, 'If an attacker sets up a WhatsApp account using your friend\'s profile picture and name to trick you, which technique are they employing?', 'a) Baiting', 'b) Spoofing', 'c) Phishing', 'd) Impersonation', 'd'),
(5, 'When an attacker creates a WhatsApp profile that impersonates a famous celebrity, this is known as:', 'a) Pretexting', 'b) Spoofing', 'c) Baiting', 'd) Impersonation', 'b'),
(6, 'Which technique is most likely to use a combination of social engineering and technical methods to deceive users?', 'a) Impersonation', 'b) Spoofing', 'c) Pretexting', 'd) Phishing', 'd'),
(7, 'An attacker offers you a gift card on WhatsApp if you provide your credit card information. This is an example of:', 'a) Phishing', 'b) Spoofing', 'c) Baiting', 'd) Impersonation', 'c'),
(8, 'If someone calls you claiming to be from your bank, asking you to verify your account details for \"security reasons,\" this is an example of:', 'a) Baiting', 'b) Spoofing', 'c) Phishing', 'd) Pretexting', 'd'),
(9, 'Creating fake accounts of authorities or organizations to send deceptive messages on WhatsApp is called:', 'a) Baiting', 'b) Spoofing', 'c) Pretexting', 'd) Impersonation', 'b'),
(10, 'If someone you thought was a coworker asked you over WhatsApp to share a confidential file, only to find out later they were an imposter, you\'ve fallen for:', 'a) Baiting', 'b) Spoofing', 'c) Impersonation', 'd) Phishing', 'c');

-- --------------------------------------------------------

--
-- Table structure for table `social_engineering_modules`
--

CREATE TABLE `social_engineering_modules` (
  `module_id` int(11) NOT NULL,
  `module_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `learning_objective` text NOT NULL,
  `duration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `social_engineering_modules`
--

INSERT INTO `social_engineering_modules` (`module_id`, `module_name`, `description`, `learning_objective`, `duration`) VALUES
(1, 'Types of social engineering attacks', 'Explains the common types and methods of social engineering attacks that target WhatsApp users.', 'Identify and describe the common types and methods of social engineering attacks that target WhatsApp users.', 15),
(2, 'Indicators of social engineering attacks', 'Teaches you how to identify and recognize the signs and clues of social engineering attacks.', 'Detect and analyse the indicators of social engineering attacks.', 10),
(3, 'Consequences of social engineering attacks', 'Illustrates the potential damage and harm that social engineering attacks can cause.', 'Understand and evaluate the consequences of social engineering attacks.', 10),
(4, 'Prevention strategies of social engineering attacks', 'Recommends the best practices and solutions to prevent or mitigate social engineering attacks.', 'Apply and demonstrate the prevention strategies of social engineering attacks.', 15);

-- --------------------------------------------------------

--
-- Table structure for table `steps`
--

CREATE TABLE `steps` (
  `step_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `step_number` int(11) NOT NULL,
  `step_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `steps`
--

INSERT INTO `steps` (`step_id`, `module_id`, `step_number`, `step_description`) VALUES
(1, 1, 0, 'Unusual Sender Email Address: Check if the email sender\'s address looks suspicious or unfamiliar. Look for misspellings or strange domain names.'),
(2, 1, 0, 'Urgent or Threatening Language: Be cautious of emails that use urgent or threatening language to create a sense of urgency.'),
(3, 1, 0, 'Request for Sensitive Information: Be wary of emails requesting personal or sensitive information like passwords, Social Security numbers, or credit card details.'),
(4, 1, 0, 'Unsolicited Attachments or Links: Avoid opening attachments or clicking links in emails from unknown or unexpected sources.'),
(5, 1, 0, 'Too Good to Be True Offers: Be skeptical of emails promising incredible rewards or opportunities that seem too good to be true.'),
(6, 1, 0, 'Mismatched URLs: Hover over links to see the actual URL. Check if it matches the displayed text and if it leads to a legitimate site.'),
(7, 1, 0, 'Grammatical Errors and Typos: Look for poor grammar, spelling mistakes, or awkward phrasing, which may indicate a scam.'),
(8, 1, 0, 'Unusual Requests from Known Contacts: Verify any unusual requests (like money transfers) from familiar contacts, as their accounts may be compromised.'),
(9, 1, 0, 'Requests for Secrecy: Be cautious of emails that ask you to keep the conversation or request secret. Legitimate entities usually won\'t do this.'),
(10, 1, 0, 'Check for HTTPS: Ensure that websites you interact with have \"https://\" in the URL for secure connections.');

-- --------------------------------------------------------

--
-- Table structure for table `step_images`
--

CREATE TABLE `step_images` (
  `image_id` int(11) NOT NULL,
  `step_id` int(11) NOT NULL,
  `image_data` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `username`, `email`, `password`, `role`) VALUES
(1, 'losycar', 'hezuxere', 'vemu@mailinator.com', '$2y$10$D9ful4KUcXmxWujItWKFwu/WMy11VB8kG05pTmFOpji8DlBFd9d.i', 'user'),
(2, 'babajide tomoshegbo', 'babajide234', 'babajide234@gmail.com', '$2y$10$5gtm29Njd4b6Z8ylgES0Iur4DdhhqZsx/MpDvzDbue6yAm/qDfkaq', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `user_progress`
--

CREATE TABLE `user_progress` (
  `user_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `progress` int(11) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_quiz_scores`
--

CREATE TABLE `user_quiz_scores` (
  `user_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `score` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `social_engineering_modules`
--
ALTER TABLE `social_engineering_modules`
  ADD PRIMARY KEY (`module_id`);

--
-- Indexes for table `steps`
--
ALTER TABLE `steps`
  ADD PRIMARY KEY (`step_id`),
  ADD KEY `module_id` (`module_id`);

--
-- Indexes for table `step_images`
--
ALTER TABLE `step_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `step_id` (`step_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_progress`
--
ALTER TABLE `user_progress`
  ADD PRIMARY KEY (`user_id`,`module_id`),
  ADD KEY `module_id` (`module_id`);

--
-- Indexes for table `user_quiz_scores`
--
ALTER TABLE `user_quiz_scores`
  ADD PRIMARY KEY (`user_id`,`quiz_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `social_engineering_modules`
--
ALTER TABLE `social_engineering_modules`
  MODIFY `module_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `steps`
--
ALTER TABLE `steps`
  MODIFY `step_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `step_images`
--
ALTER TABLE `step_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `steps`
--
ALTER TABLE `steps`
  ADD CONSTRAINT `steps_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `social_engineering_modules` (`module_id`);

--
-- Constraints for table `step_images`
--
ALTER TABLE `step_images`
  ADD CONSTRAINT `step_images_ibfk_1` FOREIGN KEY (`step_id`) REFERENCES `steps` (`step_id`);

--
-- Constraints for table `user_progress`
--
ALTER TABLE `user_progress`
  ADD CONSTRAINT `user_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_progress_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `social_engineering_modules` (`module_id`);

--
-- Constraints for table `user_quiz_scores`
--
ALTER TABLE `user_quiz_scores`
  ADD CONSTRAINT `user_quiz_scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_quiz_scores_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `quiz_questions` (`question_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
