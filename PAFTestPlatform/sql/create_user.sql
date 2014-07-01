
CREATE TABLE `User` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `alias` varchar(30) not NULL UNIQUE,
    `password` varchar(512) not NULL,
    `displayname` varchar(30) default NULL,
    `create_time` datetime not NULL,
    `update_time` datetime DEFAULT NULL,
    `status` varchar(20) not NULL,
    `userinfo_id` int(11) not NULL,
    INDEX userinfo_ind (userinfo_id),
    FOREIGN KEY (userinfo_id)
        REFERENCES UserInfo (id)
        ON DELETE no action,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


