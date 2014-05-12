
CREATE TABLE `userinfo` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `department` varchar(50) not null,
    `position` varchar(20) not null,
    `mobile` varchar(20) default null,
    `telephone` varchar(20) default null,
    `othermail` varchar(50) default null,
    `otherinfo` varchar(50) default null,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


