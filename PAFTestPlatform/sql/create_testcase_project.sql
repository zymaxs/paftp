CREATE TABLE `testcaseproject` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) not null UNIQUE,
    `description` varchar(200) DEFAULT null,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
