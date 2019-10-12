-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 11 Eki 2019, 20:22:36
-- Sunucu sürümü: 5.7.26
-- PHP Sürümü: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `computereng`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `announcement`
--

DROP TABLE IF EXISTS `announcement`;
CREATE TABLE IF NOT EXISTS `announcement` (
  `ann_id` int(20) NOT NULL,
  `ann_name` varchar(30) NOT NULL,
  `ann_date` datetime(6) NOT NULL,
  `ann_content` varchar(500) NOT NULL,
  `std_id` int(20) NOT NULL,
  `teacher_id` int(20) NOT NULL,
  PRIMARY KEY (`ann_id`),
  KEY `std_id` (`std_id`,`teacher_id`),
  KEY `teacher_id` (`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `class`
--

DROP TABLE IF EXISTS `class`;
CREATE TABLE IF NOT EXISTS `class` (
  `class_id` int(20) NOT NULL,
  `class_name` varchar(20) NOT NULL,
  `class_no` varchar(20) NOT NULL,
  `lesson_name` varchar(20) NOT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `courses`
--

DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `course_id` int(20) NOT NULL,
  `course_name` varchar(30) NOT NULL,
  `course_attandance` int(2) NOT NULL,
  `course_content` text NOT NULL,
  `course_hours` int(2) NOT NULL,
  `teacher_id` int(20) NOT NULL,
  `std_id` int(20) NOT NULL,
  PRIMARY KEY (`course_id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `std_id` (`std_id`),
  KEY `std_id_2` (`std_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `exams`
--

DROP TABLE IF EXISTS `exams`;
CREATE TABLE IF NOT EXISTS `exams` (
  `exam_id` int(20) NOT NULL,
  `exam_name` varchar(20) NOT NULL,
  `exam_attandace` varchar(50) NOT NULL,
  `exam_date` date NOT NULL,
  `exam_class` varchar(10) NOT NULL,
  `exam_hours` time(4) NOT NULL,
  `std_id` int(20) NOT NULL,
  `teacher_id` int(20) NOT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `std_id` (`std_id`),
  KEY `std_id_2` (`std_id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `std_id_3` (`std_id`,`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `students`
--

DROP TABLE IF EXISTS `students`;
CREATE TABLE IF NOT EXISTS `students` (
  `std_id` int(20) NOT NULL,
  `std_name` varchar(30) NOT NULL,
  `std_surname` varchar(30) NOT NULL,
  `std_mail` varchar(30) NOT NULL,
  `std_phone` varchar(20) NOT NULL,
  `std_adress` varchar(150) NOT NULL,
  `std_age` int(2) NOT NULL,
  `std_gender` text NOT NULL,
  `std_class` int(1) NOT NULL,
  `std_city` text NOT NULL,
  `teacher_id` int(20) NOT NULL,
  `exam_id` int(20) NOT NULL,
  `course_id` int(20) NOT NULL,
  PRIMARY KEY (`std_id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `exam_id` (`exam_id`,`course_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `teachers`
--

DROP TABLE IF EXISTS `teachers`;
CREATE TABLE IF NOT EXISTS `teachers` (
  `teacher_id` int(20) NOT NULL,
  `teacher_name` varchar(30) NOT NULL,
  `teacher_surname` varchar(30) NOT NULL,
  `teacher_mail` varchar(30) NOT NULL,
  `teacher_phone` varchar(20) NOT NULL,
  `teacher_adress` varchar(150) NOT NULL,
  `teacher_course` text NOT NULL,
  `teacher_age` int(2) NOT NULL,
  `teacher_gender` text NOT NULL,
  `teaacher_profession` text NOT NULL,
  `teacher_city` text NOT NULL,
  `std_id` int(20) NOT NULL,
  PRIMARY KEY (`teacher_id`),
  KEY `std_id` (`std_id`),
  KEY `std_id_2` (`std_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `announcement`
--
ALTER TABLE `announcement`
  ADD CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`),
  ADD CONSTRAINT `announcement_ibfk_2` FOREIGN KEY (`std_id`) REFERENCES `students` (`std_id`);

--
-- Tablo kısıtlamaları `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `teachers` (`teacher_id`);

--
-- Tablo kısıtlamaları `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`),
  ADD CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`std_id`) REFERENCES `students` (`std_id`);

--
-- Tablo kısıtlamaları `exams`
--
ALTER TABLE `exams`
  ADD CONSTRAINT `exams_ibfk_1` FOREIGN KEY (`std_id`) REFERENCES `students` (`std_id`),
  ADD CONSTRAINT `exams_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`);

--
-- Tablo kısıtlamaları `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`),
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`exam_id`),
  ADD CONSTRAINT `students_ibfk_3` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Tablo kısıtlamaları `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`std_id`) REFERENCES `students` (`std_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
