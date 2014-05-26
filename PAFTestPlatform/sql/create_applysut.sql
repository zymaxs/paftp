
CREATE TABLE `applysut` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `applytime` Date not NULL,
    `resolvetime` Date DEFAULT NULL,
    `action` varchar(20) DEFAULT NULL,
    `comment` varchar(200) DEFAULT NULL,
     `user_id` int(11) not NULL,
     `code` varchar(20) NOT NULL UNIQUE,
     `name` varchar(100) NOT NULL,
     `description` varchar(200) DEFAULT NULL,
     `group_id` int(11) DEFAULT NULL,
    INDEX user_ind (user_id),
    FOREIGN KEY (user_id)
        REFERENCES user (id)
        ON DELETE no action,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;