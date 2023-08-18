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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_day`
--

LOCK TABLES `alarm_day` WRITE;
/*!40000 ALTER TABLE `alarm_day` DISABLE KEYS */;
INSERT INTO `alarm_day` VALUES (1,'월요일',1),(2,'화요일',1),(3,'수요일',1),(4,'목요일',1),(5,'금요일',1),(6,'토요일',1),(7,'일요일',1),(10,'금요일',2),(11,'토요일',3),(12,'일요일',3),(13,'월요일',4),(14,'화요일',4),(15,'수요일',4),(16,'목요일',4),(17,'금요일',4),(18,'토요일',4),(19,'일요일',4),(20,'월요일',6),(21,'수요일',6),(22,'금요일',6);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_group`
--

LOCK TABLES `alarm_group` WRITE;
/*!40000 ALTER TABLE `alarm_group` DISABLE KEYS */;
INSERT INTO `alarm_group` VALUES (1,'2023-08-18 10:14:40','2023-08-18 10:16:35','얼굴 인식','기본 알림음',_binary '\0',_binary '\0','19:17:00','제목',2),(2,'2023-08-18 10:18:08','2023-08-18 10:21:03','얼굴 인식','기본 알림음',_binary '\0',_binary '','19:22:00','일어나',4),(3,'2023-08-18 10:24:30',NULL,'얼굴 인식','기본 알림음',_binary '\0',_binary '','19:24:00','알람그룹11',2),(4,'2023-08-18 10:24:50',NULL,'얼굴 인식','기본 알림음',_binary '\0',_binary '','19:25:00','빨리',4),(5,'2023-08-18 10:25:02',NULL,'얼굴 인식','기본 알림음',_binary '\0',_binary '\0','23:24:00','싸피스터디',2),(6,'2023-08-18 10:25:58','2023-08-18 10:26:07','얼굴 인식','기본 알림음',_binary '\0',_binary '\0','19:26:00','들어와',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_group_member`
--

LOCK TABLES `alarm_group_member` WRITE;
/*!40000 ALTER TABLE `alarm_group_member` DISABLE KEYS */;
INSERT INTO `alarm_group_member` VALUES (1,'2023-08-18 10:14:40',NULL,'방장',_binary '',1,2),(2,'2023-08-18 10:18:08','2023-08-18 10:19:28','방장',_binary '',2,4),(3,'2023-08-18 10:24:30',NULL,'방장',_binary '',3,2),(4,'2023-08-18 10:24:50',NULL,'방장',_binary '',4,4),(5,'2023-08-18 10:25:02',NULL,'방장',_binary '',5,2),(6,'2023-08-18 10:25:58',NULL,'방장',_binary '',6,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarm_group_request`
--

LOCK TABLES `alarm_group_request` WRITE;
/*!40000 ALTER TABLE `alarm_group_request` DISABLE KEYS */;
INSERT INTO `alarm_group_request` VALUES (1,'2023-08-18 10:24:45',NULL,'요청상태',3,2,4),(2,'2023-08-18 10:25:44',NULL,'요청상태',4,4,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_log`
--

LOCK TABLES `alert_log` WRITE;
/*!40000 ALTER TABLE `alert_log` DISABLE KEYS */;
INSERT INTO `alert_log` VALUES (1,'2023-08-18 10:24:30',NULL,_binary '\0','친구 수락',NULL,4,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fcm_token`
--

LOCK TABLES `fcm_token` WRITE;
/*!40000 ALTER TABLE `fcm_token` DISABLE KEYS */;
INSERT INTO `fcm_token` VALUES (1,'2023-08-18 10:14:14',NULL,'기 식별자','fcm 토큰값',1),(2,'2023-08-18 10:14:34',NULL,'SP1A.210812.016','dFh9p52LTlmfU9-f2dWyWV:APA91bH9dQP2pcCiT7PZAePGWUeu7J2cr-ZBA2-mTfssObZDB0yL7kULnaTQkf0IKxqM1kXPxdhEjykXGnRxzl7q7YxfTeRiDFhzm6mHnwgYvvssKFV5KPK0KLLqLhajqoJGQ-iG-gSU',2),(3,'2023-08-18 10:15:15',NULL,'TP1A.220624.014','dT0pZScZQ8KpcdyxDv73XY:APA91bGLlRPnUJm62W2YUGQCHaOHv5tUMSKHuUXceL0XGxn-ZzDKq5TwplXFuiEUEnu7XhZeg86MVk4DwEKWPiv6fmCf1UVfB0758kNkmY2LPZH5x7c3m6qSQJ8gEVPt-CktWjG06dhq',3),(4,'2023-08-18 10:17:38',NULL,'TP1A.220624.014','cOMJFPj2QyiQp4zapoI3gb:APA91bEUTr8cp2YAZbp9XIGh7G6diVgP4XwhYLEXz5TN3e8TftrEeCovy2j4Rc_R6XfIt1VsucXopL-s8R7PSKTQmhZwH-kPFfqwv-ZiEFIvwKn4FdJTLBdkOHotT4uoo2ZQcNOXqNlJ',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend`
--

LOCK TABLES `friend` WRITE;
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
INSERT INTO `friend` VALUES (1,'2023-08-18 10:24:30',NULL,2,4),(2,'2023-08-18 10:24:30',NULL,4,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_request`
--

LOCK TABLES `friend_request` WRITE;
/*!40000 ALTER TABLE `friend_request` DISABLE KEYS */;
INSERT INTO `friend_request` VALUES (1,'2023-08-18 10:24:17','2023-08-18 10:24:31','수락상태',2,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'2023-08-18 10:14:13',NULL,NULL,_binary '','kakao_12323212122123',NULL),(2,'2023-08-18 10:14:34','2023-08-18 10:14:36','ㅇㅇㅇ',_binary '','kakao_2943160061',NULL),(3,'2023-08-18 10:15:15','2023-08-18 10:15:20','성구',_binary '','kakao_2933280783',NULL),(4,'2023-08-18 10:17:38','2023-08-18 10:17:51','친구1',_binary '','kakao_2964362528',NULL);
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
INSERT INTO `member_token` VALUES (1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwNDQxNzI1MywidXNlcm5hbWUiOiJrYWthb18xMjMyMzIxMjEyMjEyMyJ9.du-BqncRvO0RcBpvfFbWS70ocTph5rqXpfbOwPOmZ2IRGZN0ATHV3I62ulw9Qjgf75q67BPEgIXiTHQ0XFFh3Q','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MDQ0MTcyNTN9.SaJyq7v_yIG8APg5fY7WfDN8kfDrLmiQCeMViIIPMAe9H7xwmHzf3vMUpp-7aYBWeNHy6AQsh_ueQQcRVmQLDw'),(2,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwNDQxNzI3NCwidXNlcm5hbWUiOiJrYWthb18yOTQzMTYwMDYxIn0.-5h5xWJ-YhDjJ8v7i7lii8nQ8d-DEZ_Q-5oEMVDKsfl5uI5AitnRDO4OI8M7wOIiLrBgCMGMQi-btsVG4bQNFA','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MDQ0MTcyNzR9.J2iztkXHIbq1hdANKuN93rtMry4Jwhp9-pprCzUdmRdV5hnlPj8v98vQXJCV19lEa-I21cuZNPodVgpqOMWCYw'),(3,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwNDQxNzUzNiwidXNlcm5hbWUiOiJrYWthb18yOTMzMjgwNzgzIn0.zMneLttk8dgdv8GrICCtmXwltZt3R6tT-hzqTfdHP_YKtL4q36ARTKxokaQtQtMP_z3tuJh_W3F7ieJFrzl3og','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MDQ0MTc1MzZ9.iK6UZ1bK6abZXgBwzneD7pYLGm5a7tj6FZlt0zXjN56rL_dCxOtjRTml-B6Z3WyLeQVlTx2Zg_L9H9RvfJLuvw'),(4,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwNDQxNzQ2NCwidXNlcm5hbWUiOiJrYWthb18yOTY0MzYyNTI4In0.-H_cMhOg16-19V0bwkS0D68XfTpiK-ZkSXp2JV7afBaC-xbvmEVKRwoKlwm6__WNtdUX1HHAO_fwu1FCO-DaxA','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE3MDQ0MTc0NjR9.uOE-zw-ZSt_o90QQvGAHvR7Lje9_A1QDGSuOV6k_ZinhTc0f7VlYkbxgaZjGu0IEnjsjuVu9TUhJZFGyDXjxIw');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_image`
--

LOCK TABLES `profile_image` WRITE;
/*!40000 ALTER TABLE `profile_image` DISABLE KEYS */;
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

-- Dump completed on 2023-08-18  1:27:19
