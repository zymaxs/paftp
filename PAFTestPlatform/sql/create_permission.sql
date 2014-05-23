CREATE TABLE `permission` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `scope` varchar(20) not NULL UNIQUE,
    `operation` varchar(20) not NULL,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;



