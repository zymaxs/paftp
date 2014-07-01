
CREATE TABLE `SutGroup` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(100) not NULL UNIQUE,
    `description` varchar(200) DEFAULT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


