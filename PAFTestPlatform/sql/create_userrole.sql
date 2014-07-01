CREATE TABLE `user_role` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `role_id` int(11) not NULL,
    `user_id` int(11) not NULL,
    `description` varchar(30) default NULL,
    INDEX role_ind (role_id),
    FOREIGN KEY (role_id)
        REFERENCES Role (id)
        ON DELETE cascade,
    INDEX user_ind (user_id),
    FOREIGN KEY (user_id)
        REFERENCES User (id)
        ON DELETE cascade,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
