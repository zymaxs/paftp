
CREATE TABLE `userinfo` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `department_id` int(11) not null,
    `position_id` int(11) not null,
    `mobile` varchar(20) default null,
    `telephone` varchar(20) default null,
    `othermail` varchar(50) default null,
    `otherinfo` varchar(50) default null,
    INDEX department_ind (department_id),
    FOREIGN KEY (department_id)
        REFERENCES userinfodepartment (id)
        ON DELETE no action,
    INDEX postion_ind (position_id),
    FOREIGN KEY (position_id)
        REFERENCES userinfoposition (id)
        ON DELETE no action,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


