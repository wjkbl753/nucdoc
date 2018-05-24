/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2018-5-24 11:30:27                           */
/*==============================================================*/


drop table if exists action;

drop table if exists artical;

drop table if exists email;

drop table if exists jidi;

drop table if exists role;

drop table if exists role_action;

drop table if exists user;

drop table if exists user_email;

drop table if exists weekreport;

/*==============================================================*/
/* Table: action                                                */
/*==============================================================*/
create table action
(
   action_id            int not null auto_increment,
   title                varchar(20) comment '权限',
   title_zh             varchar(20) comment '权限中文',
   primary key (action_id)
);

/*==============================================================*/
/* Table: artical                                               */
/*==============================================================*/
create table artical
(
   artical_id           int not null auto_increment comment '论文id',
   title                varchar(50) comment '论文题目',
   student              varchar(20) comment '学生id(和学生一对一)',
   inner_teacher        varchar(20) comment '校内教师id',
   outer_teacher        varchar(20) comment '校外教师id',
   source               varchar(20) comment '实训企业出题-实习企业项目-自拟-科研项目-学生自出题',
   primary key (artical_id)
);

/*==============================================================*/
/* Table: email                                                 */
/*==============================================================*/
create table email
(
   email_id             int not null auto_increment comment '邮件id',
   title                varchar(100) comment '邮件标题',
   content              text comment '邮件内容',
   send_people          varchar(20) comment '发件人',
   primary key (email_id)
);

/*==============================================================*/
/* Table: jidi                                                  */
/*==============================================================*/
create table jidi
(
   jidi_id              int not null auto_increment comment '基地id',
   name                 varchar(20) comment '基地名称',
   primary key (jidi_id)
);

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   role_id              int not null auto_increment,
   title                varchar(20) comment '角色名',
   title_zh             varchar(20) comment '角色中文',
   primary key (role_id)
);

/*==============================================================*/
/* Table: role_action                                           */
/*==============================================================*/
create table role_action
(
   role_id              int comment '角色id',
   action_id            int comment '权限id'
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   login_name           varchar(20) not null comment '登录名(主键)，默认和真实名一致，不允许更改',
   real_name            varchar(20) comment '真实名',
   password             varchar(100) comment '密码',
   last_ip              varchar(50) comment '上次登录ip',
   phone                varchar(20) comment '手机号',
   qq                   varchar(20) comment 'QQ号',
   email                varchar(50) comment '邮箱',
   role_id              int comment '角色id(外键)',
   jidi_id              int comment '基地id(外键)',
   primary key (login_name)
);

/*==============================================================*/
/* Table: user_email                                            */
/*==============================================================*/
create table user_email
(
   login_name           varchar(20) comment '收件人',
   email_id             int comment '邮件id',
   state                tinyint comment '0:未读，1:已读,2:待办',
   important            tinyint comment '0:不重要,1:重要'
);

/*==============================================================*/
/* Table: weekreport                                            */
/*==============================================================*/
create table weekreport
(
   weekreport_id        int not null auto_increment comment '周报id',
   name                 varchar(20) comment '学生登录名(外键)',
   content              text comment '学生周报内容',
   student_time         datetime comment '学生提交时间',
   inner_content        text comment '校内教师评语',
   outer_content        text comment '校外教师评语',
   inner_time           datetime comment '校内教师评语时间',
   outer_time           datetime comment '校外教师评语时间',
   week_num             int comment '进行周数',
   inner_score          double comment '校内教师分数',
   outer_score          double comment '校外教师分数',
   primary key (weekreport_id)
);

alter table artical add constraint FK_Reference_3 foreign key (student)
      references user (login_name) on delete restrict on update restrict;

alter table artical add constraint FK_Reference_4 foreign key (inner_teacher)
      references user (login_name) on delete restrict on update restrict;

alter table artical add constraint FK_Reference_5 foreign key (outer_teacher)
      references user (login_name) on delete restrict on update restrict;

alter table email add constraint FK_Reference_8 foreign key (send_people)
      references user (login_name) on delete restrict on update restrict;

alter table role_action add constraint FK_Reference_1 foreign key (role_id)
      references role (role_id) on delete restrict on update restrict;

alter table role_action add constraint FK_Reference_2 foreign key (action_id)
      references action (action_id) on delete restrict on update restrict;

alter table user add constraint FK_Reference_6 foreign key (role_id)
      references role (role_id) on delete restrict on update restrict;

alter table user add constraint FK_Reference_7 foreign key (jidi_id)
      references jidi (jidi_id) on delete restrict on update restrict;

alter table user_email add constraint FK_Reference_10 foreign key (email_id)
      references email (email_id) on delete restrict on update restrict;

alter table user_email add constraint FK_Reference_9 foreign key (login_name)
      references user (login_name) on delete restrict on update restrict;

alter table weekreport add constraint FK_Reference_11 foreign key (name)
      references user (login_name) on delete restrict on update restrict;

