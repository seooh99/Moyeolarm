-- MySQL dump 10.13  Distrib 8.0.34, for Linux (x86_64)
--
-- Host: localhost    Database: moyeolam_db
-- ------------------------------------------------------
-- Server version	8.0.34-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alarm_day`
--

DROP TABLE IF EXISTS `alarm_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alarm_day` (
  `alarm_day_id` bigint NOT NULL AUTO_INCREMENT,
  `day_of_week` varchar(255) DEFAULT NULL,
  `alarm_group_id` bigint DEFAULT NULL,
  PRIMARY KEY (`alarm_day_id`),
  KEY `FKpnko64xpuj55otbl0etq0qi2k` (`alarm_group_id`),
  CONSTRAINT `FKpnko64xpuj55otbl0etq0qi2k` FOREIGN KEY (`alarm_group_id`) REFERENCES `alarm_group` (`alarm_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_day`
--

LOCK TABLES `alarm_day` WRITE;
/*!40000 ALTER TABLE `alarm_day` DISABLE KEYS */;
INSERT INTO `alarm_day` VALUES (14,'금요일',4),(15,'목요일',5),(16,'금요일',5),(17,'토요일',5),(18,'목요일',6),(19,'금요일',6),(20,'토요일',6),(21,'목요일',7),(22,'금요일',7),(23,'토요일',7);
/*!40000 ALTER TABLE `alarm_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alarm_group`
--

DROP TABLE IF EXISTS `alarm_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alarm_group` (
  `alarm_group_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `alarm_mission` varchar(255) DEFAULT NULL,
  `alarm_sound` varchar(255) DEFAULT NULL,
  `lock` bit(1) DEFAULT NULL,
  `repeat` bit(1) DEFAULT NULL,
  `time` time DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `member_id` bigint DEFAULT NULL,
  PRIMARY KEY (`alarm_group_id`),
  KEY `FKcsyqgq9pn0i36y4ktfqi7qv0w` (`member_id`),
  CONSTRAINT `FKcsyqgq9pn0i36y4ktfqi7qv0w` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_group`
--

LOCK TABLES `alarm_group` WRITE;
/*!40000 ALTER TABLE `alarm_group` DISABLE KEYS */;
INSERT INTO `alarm_group` VALUES (1,'2023-08-18 10:54:30','2023-08-18 10:59:26','얼굴 인식','기본 알림음',_binary '\0',_binary '','20:00:00','제목',3),(2,'2023-08-18 10:57:36','2023-08-18 11:03:21','얼굴 인식','기본 알림음',_binary '\0',_binary '','20:04:00','테스트',2),(3,'2023-08-18 11:02:35',NULL,'얼굴 인식','기본 알림음',_binary '\0',_binary '\0','20:03:00','제목',4),(4,'2023-08-18 11:04:54',NULL,'얼굴 인식','기본 알림음',_binary '\0',_binary '','20:05:00','제목',3),(5,'2023-08-18 11:06:08',NULL,'얼굴 인식','기본 알림음',_binary '\0',_binary '','20:07:00','제목',5),(6,'2023-08-18 11:07:41',NULL,'얼굴 인식','기본 알림음',_binary '\0',_binary '','20:08:00','제목',5),(7,'2023-08-18 11:08:54',NULL,'얼굴 인식','기본 알림음',_binary '\0',_binary '','20:10:00','제목',5);
/*!40000 ALTER TABLE `alarm_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alarm_group_member`
--

DROP TABLE IF EXISTS `alarm_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alarm_group_member` (
  `alarm_group_member_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `alarm_group_member_role` varchar(255) DEFAULT NULL,
  `alarm_toggle` bit(1) DEFAULT NULL,
  `alarm_group_id` bigint DEFAULT NULL,
  `member_id` bigint DEFAULT NULL,
  PRIMARY KEY (`alarm_group_member_id`),
  KEY `FKhykd7kf8ppvndupbh8q8927q8` (`alarm_group_id`),
  KEY `FK88m48952tbnqinieg4vpapop2` (`member_id`),
  CONSTRAINT `FK88m48952tbnqinieg4vpapop2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FKhykd7kf8ppvndupbh8q8927q8` FOREIGN KEY (`alarm_group_id`) REFERENCES `alarm_group` (`alarm_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_group_member`
--

LOCK TABLES `alarm_group_member` WRITE;
/*!40000 ALTER TABLE `alarm_group_member` DISABLE KEYS */;
INSERT INTO `alarm_group_member` VALUES (6,'2023-08-18 11:04:54',NULL,'방장',_binary '',4,3),(7,'2023-08-18 11:05:02',NULL,'일반 사용자',_binary '\0',4,4),(8,'2023-08-18 11:06:08',NULL,'방장',_binary '',5,5),(10,'2023-08-18 11:07:41',NULL,'방장',_binary '',6,5),(12,'2023-08-18 11:08:54',NULL,'방장',_binary '',7,5),(13,'2023-08-18 11:09:01','2023-08-18 11:09:04','일반 사용자',_binary '',7,2);
/*!40000 ALTER TABLE `alarm_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alarm_group_request`
--

DROP TABLE IF EXISTS `alarm_group_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alarm_group_request` (
  `alarm_group_request_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `match_status` varchar(255) DEFAULT NULL,
  `alarm_group_id` bigint DEFAULT NULL,
  `from_member_id` bigint DEFAULT NULL,
  `to_member_id` bigint DEFAULT NULL,
  PRIMARY KEY (`alarm_group_request_id`),
  KEY `FKdd0tubd204hylpp0jp62r7e8i` (`alarm_group_id`),
  KEY `FKj337lqb0w65rak0k53dijmbag` (`from_member_id`),
  KEY `FKbw07p242owd39792d8wqa21on` (`to_member_id`),
  CONSTRAINT `FKbw07p242owd39792d8wqa21on` FOREIGN KEY (`to_member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FKdd0tubd204hylpp0jp62r7e8i` FOREIGN KEY (`alarm_group_id`) REFERENCES `alarm_group` (`alarm_group_id`),
  CONSTRAINT `FKj337lqb0w65rak0k53dijmbag` FOREIGN KEY (`from_member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_group_request`
--

LOCK TABLES `alarm_group_request` WRITE;
/*!40000 ALTER TABLE `alarm_group_request` DISABLE KEYS */;
INSERT INTO `alarm_group_request` VALUES (1,'2023-08-18 11:01:50','2023-08-18 11:01:57','수락상태',2,2,4),(2,'2023-08-18 11:02:32','2023-08-18 11:04:50','삭제상태',2,2,3),(3,'2023-08-18 11:04:58','2023-08-18 11:05:03','수락상태',4,3,4),(4,'2023-08-18 11:06:18','2023-08-18 11:07:46','삭제상태',5,5,2),(5,'2023-08-18 11:07:44','2023-08-18 11:08:41','삭제상태',6,5,2),(6,'2023-08-18 11:08:56','2023-08-18 11:09:01','수락상태',7,5,2);
/*!40000 ALTER TABLE `alarm_group_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_log`
--

DROP TABLE IF EXISTS `alert_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert_log` (
  `alert_log_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `alert_check` bit(1) DEFAULT NULL,
  `alert_type` varchar(255) DEFAULT NULL,
  `alarm_group_id` bigint DEFAULT NULL,
  `from_member_id` bigint DEFAULT NULL,
  `to_member_id` bigint DEFAULT NULL,
  PRIMARY KEY (`alert_log_id`),
  KEY `FKgnbrgt243kahtuan87hvaga45` (`alarm_group_id`),
  KEY `FKkao994pi2qnbhp2ibhms5lmw9` (`from_member_id`),
  KEY `FKckpew1jxenbomxq5d0xko14nm` (`to_member_id`),
  CONSTRAINT `FKckpew1jxenbomxq5d0xko14nm` FOREIGN KEY (`to_member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FKgnbrgt243kahtuan87hvaga45` FOREIGN KEY (`alarm_group_id`) REFERENCES `alarm_group` (`alarm_group_id`),
  CONSTRAINT `FKkao994pi2qnbhp2ibhms5lmw9` FOREIGN KEY (`from_member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_log`
--

LOCK TABLES `alert_log` WRITE;
/*!40000 ALTER TABLE `alert_log` DISABLE KEYS */;
INSERT INTO `alert_log` VALUES (1,'2023-08-18 10:59:14',NULL,_binary '\0','친구 수락',NULL,4,2),(2,'2023-08-18 11:01:56',NULL,_binary '\0','알람그룹 수락',2,4,2),(3,'2023-08-18 11:02:12',NULL,_binary '\0','친구 수락',NULL,3,4),(4,'2023-08-18 11:02:14',NULL,_binary '\0','친구 수락',NULL,3,2),(5,'2023-08-18 11:02:37',NULL,_binary '\0','알람그룹 수락',2,3,2),(6,'2023-08-18 11:02:44',NULL,_binary '\0','알람그룹 수정',2,2,3),(7,'2023-08-18 11:02:44',NULL,_binary '\0','알람그룹 수정',2,2,4),(8,'2023-08-18 11:02:46',NULL,_binary '\0','알람그룹 수정',2,2,3),(9,'2023-08-18 11:02:46',NULL,_binary '\0','알람그룹 수정',2,2,4),(10,'2023-08-18 11:02:57',NULL,_binary '\0','알람그룹 수정',2,2,4),(11,'2023-08-18 11:02:57',NULL,_binary '\0','알람그룹 수정',2,2,3),(12,'2023-08-18 11:03:16',NULL,_binary '\0','알람그룹 수정',2,2,4),(13,'2023-08-18 11:03:16',NULL,_binary '\0','알람그룹 수정',2,2,3),(14,'2023-08-18 11:03:20',NULL,_binary '\0','알람그룹 수정',2,2,4),(15,'2023-08-18 11:03:20',NULL,_binary '\0','알람그룹 수정',2,2,3),(16,'2023-08-18 11:04:49',NULL,_binary '\0','알람그룹 탈퇴',2,3,2),(17,'2023-08-18 11:05:02',NULL,_binary '\0','알람그룹 수락',4,4,3),(18,'2023-08-18 11:05:31',NULL,_binary '\0','친구 수락',NULL,2,5),(19,'2023-08-18 11:06:27',NULL,_binary '\0','알람그룹 수락',5,2,5),(20,'2023-08-18 11:07:45',NULL,_binary '\0','알람그룹 탈퇴',5,2,5),(21,'2023-08-18 11:07:52',NULL,_binary '\0','알람그룹 수락',6,2,5),(22,'2023-08-18 11:08:41',NULL,_binary '\0','알람그룹 탈퇴',6,2,5),(23,'2023-08-18 11:08:43',NULL,_binary '\0','알람그룹 해체',2,2,4),(24,'2023-08-18 11:09:01',NULL,_binary '\0','알람그룹 수락',7,2,5);
/*!40000 ALTER TABLE `alert_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fcm_token`
--

DROP TABLE IF EXISTS `fcm_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fcm_token` (
  `fcm_token_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `device_identifier` varchar(255) DEFAULT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `member_id` bigint DEFAULT NULL,
  PRIMARY KEY (`fcm_token_id`),
  KEY `FK7ft2nhuq76kr2yik8uw906q1i` (`member_id`),
  CONSTRAINT `FK7ft2nhuq76kr2yik8uw906q1i` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fcm_token`
--

LOCK TABLES `fcm_token` WRITE;
/*!40000 ALTER TABLE `fcm_token` DISABLE KEYS */;
INSERT INTO `fcm_token` VALUES (2,'2023-08-18 10:50:21',NULL,'TP1A.220624.014','f907IO2gTmWV5BqvJ9ehTS:APA91bH25cWs3yhtCrcIBYnOvcY-ZjxiS9NUk0ya_8BL-ULbgUWmwtINmoRRRwKxWZRll-WQg5ydz5wIlmg55R7KsB7yr5iD123chxi9ZmrePR9nNMoqN5bwQe4kQv8DLlpbfDX7Wm_2',2),(3,'2023-08-18 10:54:20',NULL,'SP1A.210812.016','f23DMbHbTM6Yju3J23cAxN:APA91bEuxCrAgBOvUUL1SxDDFjFFvUt2mNP1mDDdj-xFw7wyqOoE2L35cpvSxcye440XVxoDcC7bxVXiRW4TfIRalsY6UPUfE_tE_SjSJ8OGKyelzC45fscyTvHhhD7QcN_KtD5Nx7Ut',3),(4,'2023-08-18 10:57:29',NULL,'TP1A.220624.014','efP4CACqST2nucoJDgD0we:APA91bF_d3RK9CewOvG3PVxNt23ZuLOEyZx-BriFxzOb1riyjeQPk-5HCM6RA_RCO7F1loby-5ZU0bX46_4p2jyD2pxRoFCm1ZaoS_i7lboKXYu0eUkK2AAa0wRP0Dm7HcB0jkWQnEry',2),(5,'2023-08-18 10:58:03',NULL,'TP1A.220624.014','enQ-jj4KT2yj_T70ToXiCY:APA91bEGT1Yl9DjB-W28R9eYLFti_l5mlRmSymc17nnGTjmpXlMD6DIQoGCtbxqba-T6Bp_oROu8fwXE501ScpxVTgsZNu6NYpWGfoJWTHjPHiBmFK0GiBXrq-5Kmj2FDHXXePVw74vt',4),(6,'2023-08-18 11:01:54',NULL,'SP1A.210812.016','efVsyuT5TTOaN5Dt_XALaX:APA91bH0wOFRYcG93fvwGFR4F7AbwNH0v2pl6_0kpNn_2OUcwRfemUQzCo13b1qw3qxMtB-GgqYAstkQmI8f1ITfG2pdB8uYn1_b4Ce2sUGi5hPYdRcGqa1IHBaJKM6G5vVdWcphy1kv',3),(7,'2023-08-18 11:04:38',NULL,'TP1A.220624.014','cVnr4Ma2RqaCtEtOQOeigk:APA91bGcWFc6XEvyRjnQkO9FyKcbgHmhua2TBJ46ikWkR-M_iUOFzfSWPhQq6NcEvdWjj2RJqcpBQjrYXg5SdWjM2TeusA966HX-6Q4hCDbu6gN08IcmoduI2_FSLeRQjvvFPXA1ON7p',5);
/*!40000 ALTER TABLE `fcm_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend`
--

DROP TABLE IF EXISTS `friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend` (
  `friend_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `member_id` bigint DEFAULT NULL,
  `my_friend_id` bigint DEFAULT NULL,
  PRIMARY KEY (`friend_id`),
  KEY `FKct26voesvhe5guitpxghn722s` (`member_id`),
  KEY `FKb8k6w5k7u2n3rpk45lk1wh7qk` (`my_friend_id`),
  CONSTRAINT `FKb8k6w5k7u2n3rpk45lk1wh7qk` FOREIGN KEY (`my_friend_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FKct26voesvhe5guitpxghn722s` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend`
--

LOCK TABLES `friend` WRITE;
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
INSERT INTO `friend` VALUES (1,'2023-08-18 10:59:14',NULL,2,4),(2,'2023-08-18 10:59:14',NULL,4,2),(3,'2023-08-18 11:02:12',NULL,4,3),(4,'2023-08-18 11:02:12',NULL,3,4),(5,'2023-08-18 11:02:14',NULL,2,3),(6,'2023-08-18 11:02:14',NULL,3,2),(7,'2023-08-18 11:05:31',NULL,5,2),(8,'2023-08-18 11:05:31',NULL,2,5);
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_request`
--

DROP TABLE IF EXISTS `friend_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend_request` (
  `friend_request_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `match_status` varchar(255) DEFAULT NULL,
  `from_member_id` bigint DEFAULT NULL,
  `to_member_id` bigint DEFAULT NULL,
  PRIMARY KEY (`friend_request_id`),
  KEY `FKbb73dwgp3eryuocfb8u4pwa0e` (`from_member_id`),
  KEY `FKdbo985jwad5kt69vdtpfhuiwq` (`to_member_id`),
  CONSTRAINT `FKbb73dwgp3eryuocfb8u4pwa0e` FOREIGN KEY (`from_member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `FKdbo985jwad5kt69vdtpfhuiwq` FOREIGN KEY (`to_member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_request`
--

LOCK TABLES `friend_request` WRITE;
/*!40000 ALTER TABLE `friend_request` DISABLE KEYS */;
INSERT INTO `friend_request` VALUES (1,'2023-08-18 10:59:06','2023-08-18 10:59:15','수락상태',2,4),(2,'2023-08-18 11:02:07','2023-08-18 11:02:15','수락상태',2,3),(3,'2023-08-18 11:02:10','2023-08-18 11:02:12','수락상태',4,3),(4,'2023-08-18 11:04:51','2023-08-18 11:05:32','수락상태',5,2);
/*!40000 ALTER TABLE `friend_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `member_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `notification_toggle` bit(1) DEFAULT NULL,
  `oauth_identifier` varchar(255) DEFAULT NULL,
  `oauth_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (2,'2023-08-18 10:50:21','2023-08-18 10:50:31','강성구',_binary '','kakao_2933280783',NULL),(3,'2023-08-18 10:54:20','2023-08-18 10:54:23','이용준',_binary '','kakao_2943160061',NULL),(4,'2023-08-18 10:58:03','2023-08-18 10:58:44','탁성건',_binary '','kakao_2964362528',NULL),(5,'2023-08-18 11:04:38','2023-08-18 11:04:44','임서희',_binary '','kakao_2964230353',NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_login_log`
--

DROP TABLE IF EXISTS `member_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_login_log` (
  `member_login_log_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `remote_addr` varchar(255) DEFAULT NULL,
  `member_id` bigint DEFAULT NULL,
  PRIMARY KEY (`member_login_log_id`),
  KEY `FK9bq0bnqepxer1l9mb5c470khm` (`member_id`),
  CONSTRAINT `FK9bq0bnqepxer1l9mb5c470khm` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_login_log`
--

LOCK TABLES `member_login_log` WRITE;
/*!40000 ALTER TABLE `member_login_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_token`
--

DROP TABLE IF EXISTS `member_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_token` (
  `member_id` bigint NOT NULL,
  `acess_token` varchar(255) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  CONSTRAINT `FK8uk16sn1yy5lpqkdpnrvm11ap` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_token`
--

LOCK TABLES `member_token` WRITE;
/*!40000 ALTER TABLE `member_token` DISABLE KEYS */;
INSERT INTO `member_token` VALUES (2,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwNDQyMDA0NywidXNlcm5hbWUiOiJrYWthb18yOTMzMjgwNzgzIn0.TVFnJKF1wYoR1c3ASyLzwXw_oO-elysTmVdmscAmutyxmBFMIF8RKqey-F2eLYRrCSzbeRjIt6zfO8AivyPxdg','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MDQ0MjAwNDd9.ohSVDmgbC_gxhys3FOxaJtnB652ZUVNUkfSwosloXI4wZ7YbE7Qe7dQfqZggCHKHa2vgWgrsbLY7L0BVVcOHfQ'),(3,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwNDQyMDExNCwidXNlcm5hbWUiOiJrYWthb18yOTQzMTYwMDYxIn0.hrUXu7enObaR797JL7k-X8_D_borKXG30OoOB58_afeSAoBFAJZ62_5fNa_l9Wn4s6ZfghU7MS7B8XHbqlFSeQ','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MDQ0MjAxMTR9.CTFhDCOevyWdH7rgaFCmyr8dqUILD1DTlmNkUUzv1A7iq827Kj70KSD8gtF2GayEIDV9OqARRdthw6MwPrJdvQ'),(4,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwNDQyMDA1MCwidXNlcm5hbWUiOiJrYWthb18yOTY0MzYyNTI4In0.QGBUgC1aKYJAnYy0fBvwKJL3-cK3_HqsuuS81RY_eiQLQhjr_XFO-hLVsVEczqcrbR4F0TyT_EBAU1naibV-ww','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MDQ0MjAwNTB9.8MSJWFklv5xiU1iB241pvBfMmkrTXNhEh8EJWD8p0Ehl6Xs1nrcHb67g0jzMmfdfJsRtfe6i5FflWOXsfj_ycA'),(5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwNDQyMDI3NywidXNlcm5hbWUiOiJrYWthb18yOTY0MjMwMzUzIn0.BO7-e2sAujbQMe04fFrMm58ivPcAe58gK9J9pjKLXxN6WCVd83lyU9LllnWYnRZkKuGIdyl5FWGNpwHN6eqvYg','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MDQ0MjAyNzd9.xBXNB_boYEmFe6WpB5hpVFezxtBo5TN8i98MPPsyfbvhlrkm2z9LNuUUehOtA0GkweQfSO9jU5wB8jgliBh-HQ');
/*!40000 ALTER TABLE `member_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_image`
--

DROP TABLE IF EXISTS `profile_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_image` (
  `profile_image_id` bigint NOT NULL AUTO_INCREMENT,
  `image_path` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `member_id` bigint DEFAULT NULL,
  PRIMARY KEY (`profile_image_id`),
  KEY `FK8hbjrw7fjb8t1g7tnmsra3o5l` (`member_id`),
  CONSTRAINT `FK8hbjrw7fjb8t1g7tnmsra3o5l` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_image`
--

LOCK TABLES `profile_image` WRITE;
/*!40000 ALTER TABLE `profile_image` DISABLE KEYS */;
INSERT INTO `profile_image` VALUES (4,NULL,'https://moyeoram.s3.ap-northeast-2.amazonaws.com/profile_image/%EA%B0%95%EC%84%B1%EA%B5%AC1692272290599.png',2),(5,NULL,'https://moyeoram.s3.ap-northeast-2.amazonaws.com/profile_image/%EC%9D%B4%EC%9A%A9%EC%A4%801692272535392.jpg',3),(6,NULL,'https://moyeoram.s3.ap-northeast-2.amazonaws.com/profile_image/%ED%83%81%EC%84%B1%EA%B1%B41692272679237.jpg',4);
/*!40000 ALTER TABLE `profile_image` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-18  2:49:47
