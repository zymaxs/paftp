CREATE TABLE `role_permission` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `role_id` int(11) not NULL,
    `permission_id` int(11) not NULL,
    `description` varchar(30) default NULL,
    INDEX role_ind (role_id),
    FOREIGN KEY (role_id)
        REFERENCES role (id)
        ON DELETE cascade,
    INDEX permission_ind (permission_id),
    FOREIGN KEY (permission_id)
        REFERENCES permission (id)
        ON DELETE cascade,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;



