--drop table XXL_JOB_GROUP;
create table XXL_JOB_GROUP
( 
    ID            NUMBER not null,
    APP_NAME      VARCHAR2(150) not null,
    TITLE         VARCHAR2(50) not null,
    ADDRESS_TYPE  NUMBER not null,
    ADDRESS_LIST  CLOB,
    UPDATE_TIME   DATE 
);
comment on table XXL_JOB_GROUP
 is '执行器信息表';
comment on column XXL_JOB_GROUP.ID
 is 'id';
comment on column XXL_JOB_GROUP.APP_NAME
 is '执行器AppName';
comment on column XXL_JOB_GROUP.TITLE
 is '执行器名称';
comment on column XXL_JOB_GROUP.ADDRESS_TYPE
 is '执行器地址类型：0=自动注册、1=手动录入';
comment on column XXL_JOB_GROUP.ADDRESS_LIST
 is '执行器地址列表，多地址逗号分隔';
comment on column XXL_JOB_GROUP.UPDATE_TIME
 is '';
create index IDX_XXL_JOB_GROUP_APP_NAME on XXL_JOB_GROUP(APP_NAME) ;
create index IDX_XXL_JOB_GROUP_GROUP_ORDER on XXL_JOB_GROUP(GROUP_ORDER) ;
alter table XXL_JOB_GROUP add constraint PK_XXL_JOB_GROUP primary key (ID)  ;

--drop table XXL_JOB_INFO;
create table XXL_JOB_INFO
(
    ID                        NUMBER not null,
    JOB_GROUP                 NUMBER not null,
    JOB_DESC                  VARCHAR2(500) not null,
    ADD_TIME                  DATE,
    UPDATE_TIME               DATE,
    AUTHOR                    VARCHAR2(500),
    ALARM_EMAIL               VARCHAR2(500),
    EXECUTOR_ROUTE_STRATEGY   VARCHAR2(150),
    EXECUTOR_HANDLER          VARCHAR2(500),
    EXECUTOR_PARAM            VARCHAR2(1000),
    EXECUTOR_BLOCK_STRATEGY   VARCHAR2(150),
    EXECUTOR_TIMEOUT          NUMBER not null,
    EXECUTOR_FAIL_RETRY_COUNT NUMBER not null,
    GLUE_TYPE                 VARCHAR2(150) not null,
    GLUE_SOURCE               CLOB,
    GLUE_REMARK               VARCHAR2(128),
    GLUE_UPDATETIME           DATE,
    CHILD_JOBID               VARCHAR2(500),
    TRIGGER_STATUS            NUMBER not null,
    TRIGGER_LAST_TIME         NUMBER not null,
    TRIGGER_NEXT_TIME         NUMBER not null,
    MISFIRE_STRATEGY          VARCHAR2(50),
    SCHEDULE_TYPE             VARCHAR2(50),
    SCHEDULE_CONF             VARCHAR2(128)
) ;
comment on table XXL_JOB_INFO
 is '调度信息表';
comment on column XXL_JOB_INFO.SCHEDULE_CONF
 is '调度配置，值含义取决于调度类型';
comment on column XXL_JOB_INFO.EXECUTOR_HANDLER
 is '执行器任务handler';
comment on column XXL_JOB_INFO.EXECUTOR_PARAM
 is '执行器任务参数';
comment on column XXL_JOB_INFO.EXECUTOR_BLOCK_STRATEGY
 is '阻塞处理策略';
comment on column XXL_JOB_INFO.EXECUTOR_TIMEOUT
 is '任务执行超时时间，单位秒';
comment on column XXL_JOB_INFO.EXECUTOR_FAIL_RETRY_COUNT
 is '失败重试次数';
comment on column XXL_JOB_INFO.GLUE_TYPE
 is 'GLUE类型';
comment on column XXL_JOB_INFO.GLUE_SOURCE
 is 'GLUE源代码';
comment on column XXL_JOB_INFO.GLUE_REMARK
 is 'GLUE备注';
comment on column XXL_JOB_INFO.GLUE_UPDATETIME
 is 'GLUE更新时间';
comment on column XXL_JOB_INFO.CHILD_JOBID
 is '子任务ID，多个逗号分隔';
comment on column XXL_JOB_INFO.TRIGGER_STATUS
 is '调度状态：0-停止，1-运行';
comment on column XXL_JOB_INFO.TRIGGER_LAST_TIME
 is '上次调度时间';
comment on column XXL_JOB_INFO.TRIGGER_NEXT_TIME
 is '下次调度时间';
comment on column XXL_JOB_INFO.MISFIRE_STRATEGY
 is '调度过期策略';
comment on column XXL_JOB_INFO.SCHEDULE_TYPE
 is '调度类型';
comment on column XXL_JOB_INFO.EXECUTOR_ROUTE_STRATEGY
 is '执行器路由策略';
comment on column XXL_JOB_INFO.AUTHOR
 is '作者';
comment on column XXL_JOB_INFO.ALARM_EMAIL
 is '报警邮件';
comment on column XXL_JOB_INFO.ID
 is '主键';
comment on column XXL_JOB_INFO.JOB_GROUP
 is '执行器主键ID';
comment on column XXL_JOB_INFO.JOB_DESC
 is '任务描述';
comment on column XXL_JOB_INFO.ADD_TIME
 is '添加时间';
comment on column XXL_JOB_INFO.UPDATE_TIME
 is '更新时间';
create index IDX_XXL_JOB_AUTHOR on XXL_JOB_INFO(AUTHOR) ;
create index IDX_XXL_JOB_EXECUTOR_HANDLER on XXL_JOB_INFO(EXECUTOR_HANDLER) ;
create index IDX_XXL_JOB_JOB_GROUP on XXL_JOB_INFO(JOB_GROUP) ;
create index IDX_XXL_JOB_TRIGGER_STATUS on XXL_JOB_INFO(TRIGGER_STATUS) ;
alter table XXL_JOB_INFO add constraint PK_XXL_JOB_INFO primary key (ID)  ;

--drop table XXL_JOB_LOCK;
create table XXL_JOB_LOCK(
      LOCK_NAME VARCHAR2(150) not null
      ) ;
comment on table XXL_JOB_LOCK
 is '锁信息';
comment on column XXL_JOB_LOCK.LOCK_NAME
 is '锁名称';
alter table XXL_JOB_LOCK add constraint PK_XXL_JOB_LOCK primary key (LOCK_NAME)  ;

--drop table XXL_JOB_LOG;
create table XXL_JOB_LOG
(
    ID                        NUMBER not null,
    JOB_GROUP                 NUMBER not null,
    JOB_ID                    NUMBER not null,
    EXECUTOR_ADDRESS          VARCHAR2(500),
    EXECUTOR_HANDLER          VARCHAR2(500),
    EXECUTOR_PARAM            VARCHAR2(1000),
    EXECUTOR_SHARDING_PARAM   VARCHAR2(50),
    EXECUTOR_FAIL_RETRY_COUNT NUMBER DEFAULT 0 not null,
    TRIGGER_TIME              DATE,
    TRIGGER_CODE              NUMBER not null,
    TRIGGER_MSG               CLOB,
    HANDLE_TIME               DATE,
    HANDLE_CODE               NUMBER not null,
    HANDLE_MSG                CLOB,
    ALARM_STATUS              NUMBER DEFAULT 0 not null
);
comment on table XXL_JOB_LOG
 is '任务日志信息';
comment on column XXL_JOB_LOG.JOB_ID
 is '任务，主键ID';
comment on column XXL_JOB_LOG.EXECUTOR_ADDRESS
 is '执行器地址，本次执行的地址';
comment on column XXL_JOB_LOG.EXECUTOR_HANDLER
 is '执行器任务handler';
comment on column XXL_JOB_LOG.EXECUTOR_PARAM
 is '执行器任务参数';
comment on column XXL_JOB_LOG.EXECUTOR_SHARDING_PARAM
 is '执行器任务分片参数，格式如 1/2';
comment on column XXL_JOB_LOG.EXECUTOR_FAIL_RETRY_COUNT
 is '失败重试次数';
comment on column XXL_JOB_LOG.TRIGGER_TIME
 is '调度-时间';
comment on column XXL_JOB_LOG.TRIGGER_CODE
 is '调度-结果';
comment on column XXL_JOB_LOG.TRIGGER_MSG
 is '调度-日志';
comment on column XXL_JOB_LOG.HANDLE_TIME
 is '执行-时间';
comment on column XXL_JOB_LOG.HANDLE_CODE
 is '执行-状态';
comment on column XXL_JOB_LOG.HANDLE_MSG
 is '执行-日志';
comment on column XXL_JOB_LOG.ALARM_STATUS
 is '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';
comment on column XXL_JOB_LOG.JOB_GROUP
 is '执行器主键ID';
comment on column XXL_JOB_LOG.ID
 is '主键ID';
create index IDX_XXL_JOB_LOG_TRIGGER_CODE on XXL_JOB_LOG(TRIGGER_CODE) ;
create index IDX_XXL_JOB_LOG_TRIGGER_TIME on XXL_JOB_LOG(TRIGGER_TIME) ;
alter table XXL_JOB_LOG add constraint PK_XXL_JOB_LOG primary key (ID)  ;
create index IDX_XXL_JOB_LOG_HANDLE_CODE on XXL_JOB_LOG(HANDLE_CODE) ;
create index IDX_XXL_JOB_LOG_HANDLE_TIME on XXL_JOB_LOG(HANDLE_TIME) ;
create index IDX_XXL_JOB_LOG_JOB_GROUP on XXL_JOB_LOG(JOB_GROUP) ;
create index IDX_XXL_JOB_LOG_JOB_ID on XXL_JOB_LOG(JOB_ID) ;

--drop table XXL_JOB_LOGGLUE;
create table XXL_JOB_LOGGLUE
(
    ID          NUMBER not null,
    JOB_ID      NUMBER not null,
    GLUE_TYPE   VARCHAR2(150),
    GLUE_SOURCE CLOB,
    GLUE_REMARK VARCHAR2(256) not null,
    ADD_TIME    DATE,
    UPDATE_TIME DATE
) ;
comment on table XXL_JOB_LOGGLUE
 is '任务GLUE日志';
comment on column XXL_JOB_LOGGLUE.GLUE_SOURCE
 is 'GLUE源代码';
comment on column XXL_JOB_LOGGLUE.GLUE_REMARK
 is 'GLUE备注';
comment on column XXL_JOB_LOGGLUE.ADD_TIME
 is '添加时间';
comment on column XXL_JOB_LOGGLUE.UPDATE_TIME
 is '更新时间';
comment on column XXL_JOB_LOGGLUE.ID
 is '主键ID';
comment on column XXL_JOB_LOGGLUE.JOB_ID
 is '任务，主键ID';
comment on column XXL_JOB_LOGGLUE.GLUE_TYPE
 is 'GLUE类型';
create index IDX_XXL_JOB_LOGGLUE_JOB_ID on XXL_JOB_LOGGLUE(JOB_ID) ;
alter table XXL_JOB_LOGGLUE add constraint PK_XXL_JOB_LOGGLUE primary key (ID)  ;

--drop table XXL_JOB_LOG_REPORT;
create table XXL_JOB_LOG_REPORT
(
    ID            NUMBER(11) not null,
    TRIGGER_DAY   DATE,
    RUNNING_COUNT NUMBER(11) not null,
    SUC_COUNT     NUMBER(11) not null,
    FAIL_COUNT    NUMBER(11) not null,
    UPDATE_TIME   DATE
) ;
comment on table XXL_JOB_LOG_REPORT
 is '日志报表';
comment on column XXL_JOB_LOG_REPORT.ID
 is 'id';
comment on column XXL_JOB_LOG_REPORT.TRIGGER_DAY
 is '调度-时间';
comment on column XXL_JOB_LOG_REPORT.RUNNING_COUNT
 is '运行中-日志数量';
comment on column XXL_JOB_LOG_REPORT.SUC_COUNT
 is '执行成功-日志数量';
comment on column XXL_JOB_LOG_REPORT.FAIL_COUNT
 is '执行失败-日志数量';
comment on column XXL_JOB_LOG_REPORT.UPDATE_TIME
 is '更新时间';
alter table XXL_JOB_LOG_REPORT add constraint PK_XXL_JOB_LOG_REPORT primary key (ID)  ;

--drop table XXL_JOB_REGISTRY;
create table XXL_JOB_REGISTRY
(
    ID             NUMBER not null,
    REGISTRY_GROUP VARCHAR2(500) not null,
    REGISTRY_KEY   VARCHAR2(500) not null,
    REGISTRY_VALUE VARCHAR2(500) not null,
    UPDATE_TIME    DATE
) ;
comment on table XXL_JOB_REGISTRY
 is '执行器注册表';
comment on column XXL_JOB_REGISTRY.ID
 is '主键ID';
comment on column XXL_JOB_REGISTRY.REGISTRY_GROUP
 is '注册组';
comment on column XXL_JOB_REGISTRY.REGISTRY_KEY
 is '注册key';
comment on column XXL_JOB_REGISTRY.REGISTRY_VALUE
 is '注册value';
comment on column XXL_JOB_REGISTRY.UPDATE_TIME
 is '修改时间';
create index IDX_XXL_JOB_REGISTRY_REGISTRY_GROUP on XXL_JOB_REGISTRY(REGISTRY_GROUP) ;
create index IDX_XXL_JOB_REGISTRY_UPDATE_TIME on XXL_JOB_REGISTRY(UPDATE_TIME) ;
alter table XXL_JOB_REGISTRY add constraint PK_XXL_JOB_REGISTRY primary key (ID)  ;


--drop table XXL_JOB_USER;
create table XXL_JOB_USER
(
    ID         NUMBER not null,
    USERNAME   VARCHAR2(150) not null,
    PASSWORD   VARCHAR2(150) not null,
    ROLE       NUMBER not null,
    PERMISSION VARCHAR2(500)
) ;
comment on table XXL_JOB_USER
 is '登录用户信息';
comment on column XXL_JOB_USER.ID
 is '主键ID';
comment on column XXL_JOB_USER.USERNAME
 is '账号';
comment on column XXL_JOB_USER.PASSWORD
 is '密码';
comment on column XXL_JOB_USER.ROLE
 is '角色：0-普通用户、1-管理员';
comment on column XXL_JOB_USER.PERMISSION
 is '权限：执行器ID列表，多个逗号分割';
alter table XXL_JOB_USER add constraint PK_XXL_JOB_USER primary key (ID)  ;



-- Create sequence
create sequence XXL_JOB_GROUP_ID
minvalue 1
maxvalue 999999999999
start with 2
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_INFO_ID
minvalue 1
maxvalue 999999999999
start with 2
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_LOGGLUE_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_LOG_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_LOG_REPORT_ID
minvalue 1
maxvalue 999999999999
start with 2
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_REGISTRY_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;

-- Create sequence
create sequence XXL_JOB_USER_ID
minvalue 1
maxvalue 999999999999
start with 2
increment by 1
cache 20
cycle;

INSERT INTO xxl_job_group(id, app_name, title, address_type, address_list) VALUES (1, 'xxl-job-executor-sample', '示例执行器', 0, NULL);
INSERT INTO xxl_job_info(id, job_group, job_desc, add_time, update_time, author, alarm_email, schedule_type, schedule_conf, misfire_strategy, executor_route_strategy, executor_handler, executor_param, executor_block_strategy, executor_timeout, executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime, child_jobid,TRIGGER_STATUS,trigger_last_time,trigger_next_time) VALUES (1, 1, '测试任务1', to_date('20181103222131','yyyymmddhh24miss'), to_date('20181103222131','yyyymmddhh24miss'), 'XXL', '', 'CRON', '0 0 0 * * ? *', 'DO_NOTHING', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', to_date('20181103222131','yyyymmddhh24miss'), '',0,0,0);
INSERT INTO xxl_job_user(id, username, password, role, permission) VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);
INSERT INTO xxl_job_lock ( lock_name) VALUES ( 'schedule_lock');


