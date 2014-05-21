
CREATE TABLE `testcase` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `testsuite_id` int(11) DEFAULT NULL,
    `name` varchar(50) DEFAULT NULL,
    `priority` varchar(8) DEFAULT NULL,
    `status` varchar(20) DEFAULT NULL,
    `description` varchar(200) DEFAULT NULL,
    `creator_id` int(11) DEFAULT NULL,
    `create_time` datetime DEFAULT NULL,
    `updator_id` int(11) DEFAULT NULL,
    `update_time` datetime DEFAULT NULL,
    INDEX testsuite_ind (testsuite_id),
    FOREIGN KEY (testsuite_id)
        REFERENCES testsuite (id)
        ON DELETE set null,
    INDEX creator_ind (creator_id),
    FOREIGN KEY (creator_id)
        REFERENCES user (id)
        ON DELETE set null,
    INDEX updator_ind (updator_id),
    FOREIGN KEY (updator_id)
        REFERENCES user (id)
        ON DELETE set null,
        PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


