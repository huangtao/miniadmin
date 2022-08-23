--
-- APP数据库(MySQL)
-- huangtao117@yeah.net
--

SET FOREIGN_KEY_CHECKS = 0;

-------------------------------------------------------------------------------------------
-- 表

--------------------------------------
-- 1.日志表
--------------------------------------
DROP TABLE IF EXISTS sys_log;
CREATE TABLE sys_log(
    id BIGINT (20) NOT NULL AUTO_INCREMENT COMMENT '主键',
    title VARCHAR (50) DEFAULT '' COMMENT '标题',
    user_id BIGINT (20) DEFAULT NULL COMMENT '用户id',
    client_ip VARCHAR (128) DEFAULT '' COMMENT '用户IP地址',
    req_param TEXT COMMENT '请求参数',
    content TEXT COMMENT '详情',
    create_time DATETIME DEFAULT NOW () COMMENT '创建时间',
    PRIMARY KEY (id),
    KEY sys_log_create_time (create_time),
    KEY sys_log_user_id (user_id),
)
ENGINE = InnoDb COMMENT = '操作日志记录';

--------------------------------------
-- 2.用户表
--------------------------------------
DROP TABLE IF EXISTS sys_user;
CREATE TABLE sys_user(
    id INT NOT NULL AUTO_INCREMENT COMMENT '主键',
    username VARCHAR (128) NOT NULL COMMENT '登录账号',
    password VARCHAR (255) NOT NULL COMMENT '登录密码',
    department_id INT DEFAULT NULL COMMENT '部门id',
    name VARCHAR (32) DEFAULT NULL COMMENT '姓名',
    phone VARCHAR (20) DEFAULT NULL COMMENT '绑定手机',
    email VARCHAR (100) DEFAULT NULL COMMENT '电子邮箱',
    salt VARCHAR (20) DEFAULT '' COMMENT '盐加密',
    status CHAR (1) DEFAULT '0' COMMENT '帐号状态(0正常 1停用)',
    create_by INT DEFAULT NULL COMMENT '创建人',
    create_time DATETIME DEFAULT NOW () COMMENT '创建时间',
    remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id),
    UNIQUE (username)
)
ENGINE = InnoDb AUTO_INCREMENT = 10000 COMMENT = '用户表';
-------------------------------
-- 初始化-用户表数据
-------------------------------
INSERT INTO sys_user VALUES(1,'admin','admin',1,'超级管理员',NULL,NULL,'-ERP-',0,NULL,NULL,NULL);
INSERT INTO sys_user VALUES(1,'user','user',1,'普通用户',NULL,NULL,'-ERP-',0,NULL,NULL,NULL);

--------------------------------------
-- 3.部门表
--------------------------------------
DROP TABLE IF EXISTS sys_department;
CREATE TABLE sys_department(
    id INT NOT NULL AUTO_INCREMENT COMMENT '主键',
    name VARCHAR (255) NOT NULL COMMENT '名称',
    parent_id INT DEFAULT NULL COMMENT '父部门id',
    status CHAR (1) DEFAULT '0' COMMENT '状态(0正常 1停用)',
    create_time DATETIME DEFAULT NOW () COMMENT '创建时间',
    update_time DATETIME DEFAULT NOW () COMMENT '更新时间',
    remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id),
    UNIQUE (name),
)
ENGINE = InnoDb AUTO_INCREMENT = 100 COMMENT = '部门表';
-------------------------------
-- 初始化-部门表数据
-------------------------------
INSERT INTO sys_department VALUES(1,NULL,'企业',0,NULL,NULL,NULL);
INSERT INTO sys_department VALUES(10,1,'生产部',0,NULL,NULL,NULL);
INSERT INTO sys_department VALUES(11,1,'销售部',0,NULL,NULL,NULL);

--------------------------------------
-- 4.角色表
--------------------------------------
DROP TABLE IF EXISTS sys_role;
CREATE TABLE sys_role(
    id INT NOT NULL AUTO_INCREMENT COMMENT '主键',
    name VARCHAR (50) NOT NULL COMMENT '角色名称',
    code VARCHAR (255) NOT NULL COMMENT '角色编码',
    create_by INT DEFAULT NULL COMMENT '创建人',
    create_time DATETIME DEFAULT NOW () COMMENT '创建时间',
    update_by INT DEFAULT NULL COMMENT '更新人',
    update_time DATETIME DEFAULT NOW () COMMENT '更新时间',
    status CHAR (1) DEFAULT '0' COMMENT '角色状态(0正常 1停用)',
    remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id),
    UNIQUE (code),
) ENGINE = InnoDb AUTO_INCREMENT=100 COMMENT = '角色表';
-------------------------------
-- 初始化-角色信息表数据
-------------------------------
INSERT INTO sys_role VALUES(1,'系统管理员','admin',NULL,NOW(),NULL,NULL,0,NULL);
INSERT INTO sys_role VALUES(2,'普通用户','user',NULL,NOW(),NULL,NULL,0,NULL);
INSERT INTO sys_role VALUES(3,'游客','guest',NULL,NOW(),NULL,NULL,0,NULL);
INSERT INTO sys_role VALUES(4,'系统运维员','mainten',NULL,NOW(),NULL,NULL,0,NULL);

--------------------------------------
-- 5.权限表
--------------------------------------
DROP TABLE IF EXISTS sys_permission;
CREATE TABLE IF NOT EXISTS sys_permission(
    id INT NOT NULL COMMENT '主键',
    code VARCHAR (255) NOT NULL COMMENT '权限唯一编码',
    `name` VARCHAR (100) NOT NULL COMMENT '名称',
    `type` VARCHAR (50) NOT NULL COMMENT '类型 UI,DATA',
    parent_id INT NOT NULL COMMENT '父级编号',
    parent_ids varchar(2000) NOT NULL COMMENT '所有父级编号',
    status CHAR (1) DEFAULT '0' COMMENT '状态(0正常 1停用)',
    create_by INT DEFAULT NULL COMMENT '创建人',
    create_time DATETIME DEFAULT NOW () COMMENT '创建时间',
    update_by INT DEFAULT NULL COMMENT '更新人',
    update_time DATETIME DEFAULT NOW () COMMENT '更新时间',
    remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id),
    UNIQUE (code)
)
ENGINE = InnoDb COMMENT = '权限表';
-------------------------------
-- 初始化-权限表
-------------------------------
INSERT INTO sys_permission VALUES(1,NULL,NULL,'所有权限','UI','ROOT','0',1,NOW(),NULL,NULL,NULL);
-- 一级菜单
INSERT INTO sys_permission VALUES(100,1,'1','用户管理','UI','USER','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(101,1,'1','角色管理','UI','ROLE','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(102,1,'1','权限管理','UI','PERMISSION','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(103,1,'1','企业管理','UI','ENTERPRISE','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(104,1,'1','字典管理','UI','DICT','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(105,1,'1','日志管理','UI','LOG','0',1,NOW(),NULL,NULL,NULL);
-- 二级菜单
INSERT INTO sys_permission VALUES(200,105,'1,105','登录日志','UI','LOG_LOGIN','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(201,105,'1,105','操作日志','UI','LOG_OPERATE','0',1,NOW(),NULL,NULL,NULL);
-- 用户管理按钮
INSERT INTO sys_permission VALUES(1000,100,'1,100','查询','UI','USER_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1001,100,'1,100','新增','UI','USER_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1002,100,'1,100','修改','UI','USER_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1003,100,'1,100','删除','UI','USER_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1004,100,'1,100','导入','UI','USER_IMPORT','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1005,100,'1,100','导出','UI','USER_EXPORT','0',1,NOW(),NULL,NULL,NULL);
-- 角色管理按钮
INSERT INTO sys_permission VALUES(1020,101,'1,101','查询','UI','ROLE_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1021,101,'1,101','新增','UI','ROLE_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1022,101,'1,101','修改','UI','ROLE_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1023,101,'1,101','删除','UI','ROLE_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1024,101,'1,101','导入','UI','ROLE_IMPORT','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1025,101,'1,101','导出','UI','ROLE_EXPORT','0',1,NOW(),NULL,NULL,NULL);
-- 权限管理按钮
INSERT INTO sys_permission VALUES(1030,102,'1,102','查询','UI','PERMISSION_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1031,102,'1,102','新增','UI','PERMISSION_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1032,102,'1,102','修改','UI','PERMISSION_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1033,102,'1,102','删除','UI','PERMISSION_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1034,102,'1,102','导入','UI','PERMISSION_IMPORT','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1035,102,'1,102','导出','UI','PERMISSION_EXPORT','0',1,NOW(),NULL,NULL,NULL);
-- 企业管理按钮
INSERT INTO sys_permission VALUES(1040,103,'1,103','查询','UI','ENTERPRISE_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1041,103,'1,103','新增','UI','ENTERPRISE_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1042,103,'1,103','修改','UI','ENTERPRISE_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1043,103,'1,103','删除','UI','ENTERPRISE_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1044,103,'1,103','导入','UI','ENTERPRISE_IMPORT','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1045,103,'1,103','导出','UI','ENTERPRISE_EXPORT','0',1,NOW(),NULL,NULL,NULL);
-- 字典管理按钮
INSERT INTO sys_permission VALUES(1050,104,'1,104','查询','UI','DICT_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1051,104,'1,104','新增','UI','DICT_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1052,104,'1,104','修改','UI','DICT_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1053,104,'1,104','删除','UI','DICT_ADD','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1054,104,'1,104','导入','UI','DICT_IMPORT','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1055,104,'1,104','导出','UI','DICT_EXPORT','0',1,NOW(),NULL,NULL,NULL);
-- 日志管理按钮
INSERT INTO sys_permission VALUES(1060,200,'1,200','查询','UI','LOG_LOGIN_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1061,200,'1,200','导出','UI','LOG_LOGIN_EXPORT','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1062,201,'1,201','查询','UI','LOG_OPERATE_LIST','0',1,NOW(),NULL,NULL,NULL);
INSERT INTO sys_permission VALUES(1063,201,'1,201','导出','UI','LOG_OPERATE_EXPORT','0',1,NOW(),NULL,NULL,NULL);

--------------------------------------
-- 5.角色权限表
--------------------------------------
DROP TABLE IF EXISTS sys_role_permission;
CREATE TABLE sys_role_permission(
    role_id INT NOT NULL COMMENT '角色ID',
    permission_id INT NOT NULL COMMENT '权限ID'
    PRIMARY KEY (roleid,permission_id),
) ENGINE = InnoDb COMMENT = '角色权限表';
-------------------------------
-- 初始化-角色权限表
-------------------------------
INSERT INTO sys_role_permission VALUES(2,1);
INSERT INTO sys_role_permission VALUES(2,103);
INSERT INTO sys_role_permission VALUES(2,104);
INSERT INTO sys_role_permission VALUES(2,1040);
INSERT INTO sys_role_permission VALUES(2,1041);
INSERT INTO sys_role_permission VALUES(2,1042);
INSERT INTO sys_role_permission VALUES(2,1043);
INSERT INTO sys_role_permission VALUES(2,1045);
INSERT INTO sys_role_permission VALUES(2,1050);
INSERT INTO sys_role_permission VALUES(2,1051);
INSERT INTO sys_role_permission VALUES(2,1052);
INSERT INTO sys_role_permission VALUES(2,1053);
INSERT INTO sys_role_permission VALUES(2,1055);

--------------------------------------
-- 6.字典类型表
--------------------------------------
DROP TABLE IF EXISTS sys_dict_type;
CREATE TABLE sys_dict_type(
    id INT NOT NULL COMMENT '主键',
    `name` VARCHAR (100) NOT NULL COMMENT '名称',
    `type` VARCHAR (50) NOT NULL COMMENT '类型',
    status CHAR (1) DEFAULT '0' COMMENT '状态(0正常 1停用)',
    create_by INT DEFAULT NULL COMMENT '创建人',
    create_time DATETIME DEFAULT NOW () COMMENT '创建时间',
    update_by INT DEFAULT NULL COMMENT '更新人',
    update_time DATETIME DEFAULT NOW () COMMENT '更新时间',
    remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id),
    UNIQUE (`type`)
) ENGINE = InnoDb COMMENT = '字典类型表';
-------------------------------
-- 初始化-字典类型表
-------------------------------
INSERT INTO sys_dict_type VALUES(1,'用户性别','sys_user_sex','0','admin',NOW(),'',NULL,'用户性别列表');
INSERT INTO sys_dict_type VALUES(2,'菜单状态','sys_show_hide','0','admin',NOW(),'',NULL,'菜单状态列表');
INSERT INTO sys_dict_type VALUES(3,'系统开关','sys_normal_disable','0','admin',NOW(),'',NULL,'系统开关列表');
INSERT INTO sys_dict_type VALUES(4,'系统是否','sys_yse_no','0','admin',NOW(),'',NULL,'系统是否列表');
INSERT INTO sys_dict_type VALUES(5,'操作类型','sys_oper_type','0','admin',NOW(),'',NULL,'操作类型列表');

--------------------------------------
-- 7.字典数据表
--------------------------------------
DROP TABLE IF EXISTS sys_dict_data;
CREATE TABLE sys_dict_data(
    id INT NOT NULL COMMENT '主键',
    sort INT DEFAULT 0 COMMENT '排序',
    `name` VARCHAR (100) NOT NULL COMMENT '名称',
    `value` VARCHAR (100) NOT NULL COMMENT '键值',
    `type_id` INT NOT NULL COMMENT '字典类型id',
    is_default CHAR (1) DEFAULT 'N' COMMENT '是否默认(Y是 N否)',
    status CHAR (1) DEFAULT '0' COMMENT '状态(0正常 1停用)',
    create_by INT DEFAULT NULL COMMENT '创建人',
    create_time DATETIME DEFAULT NOW () COMMENT '创建时间',
    update_by INT DEFAULT NULL COMMENT '更新人',
    update_time DATETIME DEFAULT NOW () COMMENT '更新时间',
    remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id)
) ENGINE = InnoDb COMMENT = '字典数据表';
-------------------------------
-- 初始化-字典数据表
-------------------------------
INSERT INTO sys_dict_data VALUES(1,1,'女','0',1,'Y','0','admin',NOW(),'',NULL,'性别女');
INSERT INTO sys_dict_data VALUES(2,2,'男','1',1,'N','0','admin',NOW(),'',NULL,'性别男');
INSERT INTO sys_dict_data VALUES(3,3,'未知','2',1,'N','0','admin',NOW(),'',NULL,'性别未知');

INSERT INTO sys_dict_data VALUES(4,1,'显示','0',2,'Y','0','admin',NOW(),'',NULL,'显示菜单');
INSERT INTO sys_dict_data VALUES(5,2,'隐藏','1',2,'N','0','admin',NOW(),'',NULL,'隐藏菜单');

INSERT INTO sys_dict_data VALUES(6,1,'正常','0',3,'Y','0','admin',NOW(),'',NULL,'正常状态');
INSERT INTO sys_dict_data VALUES(7,2,'停用','1',3,'N','0','admin',NOW(),'',NULL,'停用状态');

INSERT INTO sys_dict_data VALUES(8,1,'是','0',4,'Y','0','admin',NOW(),'',NULL,'是');
INSERT INTO sys_dict_data VALUES(9,2,'否','1',4,'N','0','admin',NOW(),'',NULL,'否');

INSERT INTO sys_dict_data VALUES(10,99,'其他','0',5,'N','0','admin',NOW(),'',NULL,'其他操作');
INSERT INTO sys_dict_data VALUES(10,1,'新增','1',5,'N','0','admin',NOW(),'',NULL,'新增操作');
INSERT INTO sys_dict_data VALUES(11,2,'修改','2',5,'N','0','admin',NOW(),'',NULL,'修改操作');
INSERT INTO sys_dict_data VALUES(12,3,'删除','3',5,'N','0','admin',NOW(),'',NULL,'删除操作');
INSERT INTO sys_dict_data VALUES(13,4,'导入','4',5,'N','0','admin',NOW(),'',NULL,'导入操作');
INSERT INTO sys_dict_data VALUES(14,5,'导出','5',5,'N','0','admin',NOW(),'',NULL,'导出操作');
INSERT INTO sys_dict_data VALUES(15,6,'授权','6',5,'N','0','admin',NOW(),'',NULL,'授权操作');

---------------------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 1;
