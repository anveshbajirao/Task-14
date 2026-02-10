-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 10, 2026 at 06:17 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `company_db;`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_employee` (IN `p_name` VARCHAR(100), IN `p_department` VARCHAR(50), IN `p_salary` DECIMAL(10,2))   BEGIN
    -- Error handling
    IF p_salary <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be greater than zero';
    END IF;

    INSERT INTO employee (emp_name, department, salary)
    VALUES (p_name, p_department, p_salary);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_employee_salary_details` ()   BEGIN
    SELECT 
        emp_id,
        emp_name,
        salary,
        calculate_tax(salary) AS tax,
        salary - calculate_tax(salary) AS net_salary
    FROM employee;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_tax` (`p_salary` DECIMAL(10,2)) RETURNS DECIMAL(10,2) DETERMINISTIC BEGIN
    DECLARE tax DECIMAL(10,2);

    IF p_salary <= 30000 THEN
        SET tax = p_salary * 0.05;
    ELSEIF p_salary <= 60000 THEN
        SET tax = p_salary * 0.10;
    ELSE
        SET tax = p_salary * 0.15;
    END IF;

    RETURN tax;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `department` varchar(50) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL CHECK (`salary` > 0),
  `hire_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `emp_name`, `department`, `salary`, `hire_date`) VALUES
(1, 'Anvesh', 'IT', 50000.00, '2026-02-10'),
(2, 'Riya', 'HR', 42000.00, '2026-02-10');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--
-- Error reading structure for table company_db;.employees: #1932 - Table &#039;company_db;.employees&#039; doesn&#039;t exist in engine
-- Error reading data for table company_db;.employees: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `company_db;`.`employees`&#039; at line 1

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
