# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.17)
# Database: ideashub
# Generation Time: 2017-04-14 18:32:32 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table auth_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_group_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`)
VALUES
	(1,'Can add log entry',1,'add_logentry'),
	(2,'Can change log entry',1,'change_logentry'),
	(3,'Can delete log entry',1,'delete_logentry'),
	(4,'Can add permission',2,'add_permission'),
	(5,'Can change permission',2,'change_permission'),
	(6,'Can delete permission',2,'delete_permission'),
	(7,'Can add group',3,'add_group'),
	(8,'Can change group',3,'change_group'),
	(9,'Can delete group',3,'delete_group'),
	(10,'Can add user',4,'add_user'),
	(11,'Can change user',4,'change_user'),
	(12,'Can delete user',4,'delete_user'),
	(13,'Can add content type',5,'add_contenttype'),
	(14,'Can change content type',5,'change_contenttype'),
	(15,'Can delete content type',5,'delete_contenttype'),
	(16,'Can add session',6,'add_session'),
	(17,'Can change session',6,'change_session'),
	(18,'Can delete session',6,'delete_session'),
	(19,'Can add auth group',10,'add_authgroup'),
	(20,'Can change auth group',10,'change_authgroup'),
	(21,'Can delete auth group',10,'delete_authgroup'),
	(22,'Can add auth group permissions',11,'add_authgrouppermissions'),
	(23,'Can change auth group permissions',11,'change_authgrouppermissions'),
	(24,'Can delete auth group permissions',11,'delete_authgrouppermissions'),
	(25,'Can add auth permission',12,'add_authpermission'),
	(26,'Can change auth permission',12,'change_authpermission'),
	(27,'Can delete auth permission',12,'delete_authpermission'),
	(28,'Can add auth user',13,'add_authuser'),
	(29,'Can change auth user',13,'change_authuser'),
	(30,'Can delete auth user',13,'delete_authuser'),
	(31,'Can add auth user groups',14,'add_authusergroups'),
	(32,'Can change auth user groups',14,'change_authusergroups'),
	(33,'Can delete auth user groups',14,'delete_authusergroups'),
	(34,'Can add auth user user permissions',15,'add_authuseruserpermissions'),
	(35,'Can change auth user user permissions',15,'change_authuseruserpermissions'),
	(36,'Can delete auth user user permissions',15,'delete_authuseruserpermissions'),
	(37,'Can add comment',7,'add_comment'),
	(38,'Can change comment',7,'change_comment'),
	(39,'Can delete comment',7,'delete_comment'),
	(40,'Can add django admin log',16,'add_djangoadminlog'),
	(41,'Can change django admin log',16,'change_djangoadminlog'),
	(42,'Can delete django admin log',16,'delete_djangoadminlog'),
	(43,'Can add django content type',17,'add_djangocontenttype'),
	(44,'Can change django content type',17,'change_djangocontenttype'),
	(45,'Can delete django content type',17,'delete_djangocontenttype'),
	(46,'Can add django migrations',18,'add_djangomigrations'),
	(47,'Can change django migrations',18,'change_djangomigrations'),
	(48,'Can delete django migrations',18,'delete_djangomigrations'),
	(49,'Can add django session',19,'add_djangosession'),
	(50,'Can change django session',19,'change_djangosession'),
	(51,'Can delete django session',19,'delete_djangosession'),
	(52,'Can add idea',8,'add_idea'),
	(53,'Can change idea',8,'change_idea'),
	(54,'Can delete idea',8,'delete_idea'),
	(55,'Can add user',9,'add_user'),
	(56,'Can change user',9,'change_user'),
	(57,'Can delete user',9,'delete_user');

/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`)
VALUES
	(1,'pbkdf2_sha256$24000$qTJiun6zlRaz$Y/AH4VevAYKbQz+v9sg06CL6LKGsXtnafi5xz8F8kso=','2017-04-04 22:18:49.407028',1,'admin','','','jennifernghinguyen@gmail.com',1,1,'2017-03-05 08:56:14.875461');

/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auth_user_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_user_user_permissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `commentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ideaId` int(10) unsigned NOT NULL,
  `comment` varchar(200) NOT NULL DEFAULT '',
  `author` varchar(100) DEFAULT '',
  PRIMARY KEY (`commentId`),
  KEY `ideaId` (`ideaId`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`ideaId`) REFERENCES `idea` (`ideaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;

INSERT INTO `comment` (`commentId`, `ideaId`, `comment`, `author`)
VALUES
	(1,2,'cool!','Nghi Nguyen Jennifer'),
	(2,1,'what kind of website?','Nghi Nguyen Jennifer'),
	(3,1,'e-commercial website','Nghi Nguyen Jennifer'),
	(4,2,'thumb up!','Nghi Nguyen Jennifer'),
	(5,10,'anime!','Nghi Nguyen Jennifer'),
	(6,5,'like','Nghi Nguyen Jennifer');

/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_admin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`)
VALUES
	(1,'2017-03-05 10:11:41.516431','4','thumb up!',1,'Added.',7,1),
	(2,'2017-03-06 06:15:25.540976','3','website project: looking for students to coorporate',1,'Added.',8,1),
	(3,'2017-03-06 06:17:05.316560','4','graphic design: collaboration project',1,'Added.',8,1),
	(4,'2017-03-06 06:30:37.191985','5','Side project: mobile app',1,'Added.',8,1),
	(5,'2017-03-06 06:32:14.902677','6','Web app in progress, need graphic designer',1,'Added.',8,1),
	(6,'2017-03-06 06:41:08.159396','2','New club for gamers',2,'No fields changed.',8,1),
	(7,'2017-03-06 06:43:00.482429','5','kenny',1,'Added.',9,1),
	(8,'2017-03-06 06:49:02.856843','7','Business + side tech project: seeking ideas and partners',1,'Added.',8,1),
	(9,'2017-03-06 06:50:11.898940','8','side project: android game',1,'Added.',8,1),
	(10,'2017-03-06 06:52:23.177515','9','tech club for international student!',1,'Added.',8,1),
	(11,'2017-03-06 06:54:02.863450','10','seeking ideas for photography project!',1,'Added.',8,1),
	(12,'2017-03-06 06:54:43.021099','5','anime!',1,'Added.',7,1),
	(13,'2017-03-06 06:55:27.680878','6','like',1,'Added.',7,1);

/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_content_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;

INSERT INTO `django_content_type` (`id`, `app_label`, `model`)
VALUES
	(1,'admin','logentry'),
	(3,'auth','group'),
	(2,'auth','permission'),
	(4,'auth','user'),
	(5,'contenttypes','contenttype'),
	(10,'IdeasHub','authgroup'),
	(11,'IdeasHub','authgrouppermissions'),
	(12,'IdeasHub','authpermission'),
	(13,'IdeasHub','authuser'),
	(14,'IdeasHub','authusergroups'),
	(15,'IdeasHub','authuseruserpermissions'),
	(7,'IdeasHub','comment'),
	(16,'IdeasHub','djangoadminlog'),
	(17,'IdeasHub','djangocontenttype'),
	(18,'IdeasHub','djangomigrations'),
	(19,'IdeasHub','djangosession'),
	(8,'IdeasHub','idea'),
	(9,'IdeasHub','user'),
	(6,'sessions','session');

/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`)
VALUES
	(1,'contenttypes','0001_initial','2017-03-05 08:46:50.497670'),
	(2,'auth','0001_initial','2017-03-05 08:46:50.783409'),
	(3,'admin','0001_initial','2017-03-05 08:46:50.855066'),
	(4,'admin','0002_logentry_remove_auto_add','2017-03-05 08:46:50.889217'),
	(5,'contenttypes','0002_remove_content_type_name','2017-03-05 08:46:50.952055'),
	(6,'auth','0002_alter_permission_name_max_length','2017-03-05 08:46:50.974688'),
	(7,'auth','0003_alter_user_email_max_length','2017-03-05 08:46:51.004746'),
	(8,'auth','0004_alter_user_username_opts','2017-03-05 08:46:51.018072'),
	(9,'auth','0005_alter_user_last_login_null','2017-03-05 08:46:51.045883'),
	(10,'auth','0006_require_contenttypes_0002','2017-03-05 08:46:51.048017'),
	(11,'auth','0007_alter_validators_add_error_messages','2017-03-05 08:46:51.059183'),
	(12,'sessions','0001_initial','2017-03-05 08:46:51.090345');

/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table django_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`)
VALUES
	('gm8xymwoo0ejrnh4v2i2r92k4yl2umwl','ODc3OTU5MzkzMjAxY2I1Mzk3ZGVhZDhmNWNhMzFmNThmMTJlMWJlMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQ1M2IzOGQ5ZGY3OGJmMjRlZTBmOWE5NmNlNWFhZTMyMmY4ZTUzNmIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2017-04-03 19:19:17.849161'),
	('hugpwm3r4iutavg7l0bjfh1w2uv3z90s','ODc3OTU5MzkzMjAxY2I1Mzk3ZGVhZDhmNWNhMzFmNThmMTJlMWJlMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQ1M2IzOGQ5ZGY3OGJmMjRlZTBmOWE5NmNlNWFhZTMyMmY4ZTUzNmIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2017-03-19 08:56:23.908785'),
	('nb0wr7jarsylbkxvp6f5s6g7lzve7bcy','ODc3OTU5MzkzMjAxY2I1Mzk3ZGVhZDhmNWNhMzFmNThmMTJlMWJlMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQ1M2IzOGQ5ZGY3OGJmMjRlZTBmOWE5NmNlNWFhZTMyMmY4ZTUzNmIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2017-03-20 21:15:30.332683'),
	('rtqqtcg0jm1vymidm1umrkqcvmg03yee','ODc3OTU5MzkzMjAxY2I1Mzk3ZGVhZDhmNWNhMzFmNThmMTJlMWJlMTp7Il9hdXRoX3VzZXJfaGFzaCI6IjQ1M2IzOGQ5ZGY3OGJmMjRlZTBmOWE5NmNlNWFhZTMyMmY4ZTUzNmIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2017-04-18 22:18:49.419377');

/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table idea
# ------------------------------------------------------------

DROP TABLE IF EXISTS `idea`;

CREATE TABLE `idea` (
  `ideaId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `content` text NOT NULL,
  `date` date NOT NULL,
  `category` varchar(50) NOT NULL,
  `likes` int(10) unsigned zerofill NOT NULL,
  `author` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`ideaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `idea` WRITE;
/*!40000 ALTER TABLE `idea` DISABLE KEYS */;

INSERT INTO `idea` (`ideaId`, `title`, `content`, `date`, `category`, `likes`, `author`)
VALUES
	(1,'Need web developer work on a project from ground up','I have an idea for a new business, need web developers to build a fully functional website','2017-02-20','Technology',0000000020,'Nghi Nguyen Jennifer'),
	(2,'New club for gamers','I want to open a club for gamers in SJSU, any ideas how to start?','2017-02-28','Ideas',0000000045,'Nghi Nguyen Jennifer'),
	(3,'website project: looking for students to coorporate','I working a web app side project, looking for partners!!!','2017-03-06','Technology',0000000040,'Nghi Nguyen Jennifer'),
	(4,'graphic design: collaboration project','I am looking for ideas and partners working on a graphic design project','2017-03-06','Technology',0000000002,'Nghi Nguyen Jennifer'),
	(5,'Side project: mobile app','I am seeking for partners working on a mobile side project','2017-03-06','Ideas',0000000005,'Nghi Nguyen Jennifer'),
	(6,'Web app in progress, need graphic designer','We are looking for graphic designer working on a current web app project.','2017-03-06','Technology',0000000006,'Nghi Nguyen Jennifer'),
	(7,'Business + side tech project: seeking ideas and partners','I am having a startup idea, looking for groups to work with','2017-03-06','Business',0000000010,'Nghi Nguyen Jennifer'),
	(8,'side project: android game','any body want to join me for an side android game project?','2017-03-06','Technology',0000000000,'Nghi Nguyen Jennifer'),
	(9,'tech club for international student!','we want to start a special tech club for international student. What do you think?','2017-03-06','Business',0000000004,'Nghi Nguyen Jennifer'),
	(10,'seeking ideas for photography project!','photography project for SJSU student, seeking ideas for a theme','2017-03-06','Technology',0000000010,'Nghi Nguyen Jennifer');

/*!40000 ALTER TABLE `idea` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
