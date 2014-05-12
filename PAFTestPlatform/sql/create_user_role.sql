CREATE TABLE `user_role` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `user_id` int(11) not NULL,
    `role_id` int(11) not NULL,
    `description` varchar(30) default NULL,
    INDEX user_ind (user_id),
    FOREIGN KEY (user_id)
        REFERENCES user (id)
        ON DELETE cascade,
    INDEX role_ind (role_id),
    FOREIGN KEY (role_id)
        REFERENCES role (id)
        ON DELETE cascade,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;



