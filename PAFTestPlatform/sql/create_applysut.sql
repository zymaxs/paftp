
CREATE TABLE `ApplySut` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `applytime` datetime not NULL,
    `resolvetime` datetime DEFAULT NULL,
    `status_id` int(11) DEFAULT NULL,
    `comment` varchar(200) DEFAULT NULL,
     `user_id` int(11) not NULL,
     `code` varchar(20) NOT NULL,
     `name` varchar(100) NOT NULL UNIQUE,
     `description` varchar(200) DEFAULT NULL,
     `group_id` int(11) DEFAULT NULL,
INDEX status_ind (status_id),
    FOREIGN KEY (status_id)
        REFERENCES ApplySutStatus (id)
        ON DELETE no action,
            INDEX user_ind (user_id),
    FOREIGN KEY (user_id)
        REFERENCES User (id)
        ON DELETE no action,
        INDEX group_ind (group_id),
        FOREIGN KEY (group_id)
        REFERENCES SutGroup (id)
        ON DELETE no action,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;