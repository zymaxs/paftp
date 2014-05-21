CREATE TABLE `analysecommentcontent` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `createtime` datetime DEFAULT NULL,
    `status` varchar(10) DEFAULT NULL,
    `comment` varchar(100) DEFAULT NULL,
    `analysecommenthistory_id` int(11) DEFAULT NULL,
    INDEX analysecommenthistory_ind (analysecommenthistory_id),
    FOREIGN KEY (analysecommenthistory_id)
        REFERENCES analysecommenthistory (id)
        ON DELETE cascade,
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;