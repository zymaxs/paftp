
CREATE TABLE `applysut` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `applytime` Date not NULL,
    `resolvetime` Date DEFAULT NULL,
    `action` varchar(20) DEFAULT NULL,
    `comment` varchar(200) DEFAULT NULL,
     `user_id` int(11) not NULL,
     `approver_id` int(11) DEFAULT NULL,
     `sut_id` int(11) NOT NULL,
    INDEX user_ind (user_id),
    FOREIGN KEY (user_id)
        REFERENCES user (id)
        ON DELETE no action,
    INDEX approver_ind (approver_id),
    FOREIGN KEY (approver_id)
        REFERENCES user (id)
        ON DELETE no action,
    INDEX sut_ind (sut_id),
    FOREIGN KEY (sut_id)
        REFERENCES sut (id)
        ON DELETE no action,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;