
CREATE TABLE `sut` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `code` varchar(20) not NULL,
    `name` varchar(100) not NULL UNIQUE,
    `description` varchar(200) DEFAULT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


