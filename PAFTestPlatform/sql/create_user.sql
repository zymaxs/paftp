
CREATE TABLE `user` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `alias` varchar(30) DEFAULT NULL,
    `password` varchar(512) DEFAULT NULL,
    `displayname` varchar(20) not NULL,
    `create_time` datetime DEFAULT NULL,
    `update_time` datetime DEFAULT NULL,
    `status` varchar(20) DEFAULT NULL,
    `userinfo_id` int(11) DEFAULT NULL,
    INDEX userinfo_ind (userinfo_id),
    FOREIGN KEY (userinfo_id)
        REFERENCES userinfo (id)
        ON DELETE set null,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


