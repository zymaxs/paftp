CREATE TABLE `Role_Permission` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `role_id` int(11) not NULL,
    `permission_id` int(11) not NULL,
    `description` varchar(30) default NULL,
    INDEX role_ind (role_id),
    FOREIGN KEY (role_id)
        REFERENCES Role (id)
        ON DELETE cascade,
    INDEX permission_ind (permission_id),
    FOREIGN KEY (permission_id)
        REFERENCES Permission (id)
        ON DELETE cascade,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;



