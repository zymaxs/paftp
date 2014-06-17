
CREATE TABLE `testcase` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `testsuite_id` int(11) DEFAULT NULL,
    `casename` varchar(50) DEFAULT NULL,
    `priority` varchar(8) DEFAULT NULL,
    `status` varchar(20) DEFAULT NULL,
    `approval` varchar(20) DEFAULT NULL,
    `description` varchar(150) DEFAULT NULL,
    `creator_id` int(11) DEFAULT NULL,
    `create_time` datetime DEFAULT NULL,
	`casetype` varchar(10) DEFAULT NULL,
    `casesteps` varchar(500) DEFAULT NULL,
    `project_id` int(11) DEFAULT NULL,
    INDEX testsuite_ind (testsuite_id),
    FOREIGN KEY (testsuite_id)
        REFERENCES testsuite (id)
        ON DELETE set null,
    INDEX creator_ind (creator_id),
    FOREIGN KEY (creator_id)
        REFERENCES user (id)
        ON DELETE set null,
    INDEX project_ind (project_id),
    FOREIGN KEY (project_id)
        REFERENCES testcaseproject (id)
        ON DELETE no action,
        PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


