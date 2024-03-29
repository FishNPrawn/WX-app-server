drop database if exists fishnprawn;
# utf8mb4和utf8mb4_unicode_ci主要解决emoji表情符号不能存入数据的问题
create database fishnprawn default character set utf8mb4 collate utf8mb4_unicode_ci;
use fishnprawn;

# 创建管理员
create table `admin`
(
    `adminid`    int       not null auto_increment,
    `username`    varchar(32) not null,
    `password`    varchar(64) not null,
    `phone`       varchar(64) not null comment '用户手机号',
    `admintype`  int         not null comment '1员工，2管理员',
    `admin_create_time` timestamp   not null default current_timestamp comment '创建时间',
    `admin_update_time` timestamp   not null default current_timestamp on update current_timestamp comment '修改时间',
    primary key (`adminid`)
) comment '餐厅卖家信息表';

create table `user`(
    `id` int,
    `address` varchar(255),
    `age` int,
    `name` varchar(255)
);

create table `category`
(
    `cat_id`   int         not null auto_increment,
    `cat_name` varchar(32) not null UNIQUE,
    `cat_image` text,
    `cat_create_time` timestamp not null default current_timestamp comment '创建时间',
    `cat_update_time` timestamp not null default current_timestamp on update current_timestamp comment '修改时间',
    primary key (`cat_id`)
);


create table `good`
(
  `good_id`  int         not null auto_increment,
  `good_name` varchar(32) not null UNIQUE,
  `good_price` int not null,
  `good_stock` int not null,
  `cat_name` varchar(32) not null,
  `good_weight` double not null,
  `good_image` text not null,
  `good_status` int not null,
  `good_create_time` timestamp not null default current_timestamp comment '创建时间',
  `good_update_time` timestamp not null default current_timestamp on update current_timestamp comment '修改时间',
#   new element
  `good_image_1` text not null,
  `good_supplier` varchar(32) not null,
  `good_description` varchar(32) not null,
  `good_production` varchar(32) not null,
  `good_size` double null,
  `good_expiration` varchar(32) not null,
  `good_optimal_period` double not null,
  `good_publish_date` date not null,
  `good_image_description` text not null,
  `good_cat_image` text not null,
  primary key (`good_id`)
);

create table `wx_order_root` (
     `order_id`		int not null auto_increment,
     `order_number`  text not null comment '订单编号',
     `open_id`       text        not null,
     `access_token`  text        not null,
     `user_name`     varchar(16) not null comment '用户名',
     `user_address`  text not null comment '用户地址',
     `user_phone`    varchar(32) not null comment '用户电话',
     `order_total_price`   DECIMAL      not null comment '总金额',
     `order_create_time` timestamp not null comment '订单创造时间',
     `order_comment` text comment '备注',
     `order_status` int not null,
     `order_total_weight` double not null,
     `order_express_fee` double not null,
     `order_total_price_with_express_fee` double not null,
     primary key (`order_id`)
);


CREATE TABLE `wx_order_detail` (
    `order_detail_id`   int not null auto_increment,
    `order_number`      text not null comment '订单编号',
    `good_id`           int not null comment '商品ID',
    `good_name` varchar(64) not null,
    `good_price`        DECIMAL not null comment '商品价格',
    `good_quantity`          int not null comment '购买数量',
    `order_id`		int not null,
    `good_image` text not null,
    primary key (`order_detail_id`)
);

CREATE TABLE `wx_order_detail_remark`(
     `wx_order_detail_remark_id`   int not null auto_increment,
     `order_id` int not null,
     `remark` text not null,
     primary key (`wx_order_detail_remark_id`)
);

CREATE TABLE `shipment`(
    `shipment_id` int not null auto_increment,
    `order_number` text not null,
    `shipment_number` text not null,
    `shipment_company` text not null,
    `package_weight` float not null,
    `shipment_create_time` timestamp not null default current_timestamp,
    primary key (`shipment_id`)
);
INSERT INTO shipment
VALUES ('1', '15616516516', 'sf123456789', '顺丰', now());


CREATE TABLE `swiper_img`
(
    `swiper_img_id` int not null auto_increment,
    `image_src` text not null,
    primary key (`swiper_img_id`)
);

CREATE TABLE `good_comment`
(
    `comment_id` int not null auto_increment,
    `username` text not null,
    `good_id` int not null,
    `name` varchar(64) not null,
    `content` text not null,
    `image` text not null,
    `comment_create_time` text not null,
    primary key (`comment_id`)
);

CREATE TABLE `userinfo`
(
  `openid` varchar(64) not null,
  `session_key` varchar(64) not null,
  `username` text not null,
  `city` varchar(64),
  `phone` varchar(32),
  `user_create_time` text not null,
  primary key (`openid`)
);

CREATE TABLE `promo_code`
(
    `promo_code_header_id` int not null auto_increment,
    `username` varchar(64) not null,
    `phone` varchar(64) not null,
    `address` text not null,
    `city` varchar(32) not null,
    `remark` text not null,
    `promo_code` varchar(64) not null,
    `commission_rate` double not null,
    `discount_rate` double not null,
    primary key (`promo_code_header_id`)
);

CREATE TABLE `order_refund`
(
    `order_refund_id` int not null auto_increment,
    `order_number` text not null,
    `good_name` varchar(32) not null,
    `good_quantity` int not null,
    `refund_price` double not null,
    `refund_remark` text not null,
    `order_refund_time` timestamp not null default current_timestamp,
    primary key (`order_refund_id`)
);

CREATE TABLE `pay_supplier`
(
    `pay_supplier_id` int not null auto_increment,
    `pay_supplier` varchar(128) not null,
    `pay_supplier_date` text not null,
    `pay_supplier_price` double not null,
    `pay_supplier_or_not` int not null,
    primary key (`pay_supplier_id`)
);
INSERT INTO promo_code
VALUES (1, '杨洋', '139222610000', '广州市花都区工业区', '广州', '无备注', 'yy123', 0.1, 0.02);

INSERT INTO userinfo
VALUES ('1561651awef', 'wafwqfeqgaergae==', 'jaying', 'gz', '13952556310',now());

INSERT INTO good_comment
VALUES (1, 'jayingyoung', 4, 'jayingyoung', '此用户没有填写评价', 'url', now());


INSERT INTO good
VALUES (1, 'rockfish', 10, 100, 'fish1', 10, 'hi.jpg', 1, now(), now(), 'hi.jpg', 'hihi', 'hi', 5, '2001', '5','3', now(), 'hihi'  );


# 创建一个默认管理员 账号密码都是fishnprawn
INSERT INTO admin
VALUES (1, 'testAccount', 'fishnprawn', 'fishnprawn', 2, now(), now());
INSERT INTO admin
VALUES (2, 'jaying', '$2a$10$.E9XFBwG7kcCqAqSIbSml.ga6KrZ01SOt6y0gJl3vhllP6yBxmYpe', 'fishnprawn', 2, now(), now());


INSERT INTO category
VALUES (1, 'fish1','https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80', now(), now());
INSERT INTO category
VALUES (2, 'fish2', now(), now());
INSERT INTO category
VALUES (3, 'fish3', now(), now());
INSERT INTO category
VALUES (4, 'crab', now(), now());
INSERT INTO category
VALUES (5, 'shrimp', now(), now());
INSERT INTO good
VALUES (2, 'test1', 10, 100, 'fish2', 10, 'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80', 1, now(), now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%2Fimages%2F20170722%2F1500703140_22719_3.jpg&refer=http%3A%2F%2Fimage.cnpp.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=7f29be1bae61c9e53833b0cbf8816652', 'hihi', 'hi', 5, '2001', '5','3', now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdpic.tiankong.com%2Fsh%2Fj8%2FQJ8129672480.jpg%3Fx-oss-process%3Dstyle%2Fshow&refer=http%3A%2F%2Fdpic.tiankong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=e3bbaf5dfa465b8bc6f5bac3f836904e');
INSERT INTO good
VALUES (3, 'test2', 10, 100, 'fish1', 10, 'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1288253704,1740363863&fm=26&gp=0.jpg', 1, now(), now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%2Fimages%2F20170722%2F1500703140_22719_3.jpg&refer=http%3A%2F%2Fimage.cnpp.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=7f29be1bae61c9e53833b0cbf8816652', 'hihi', 'hi', 5, '2001', '5','3', now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdpic.tiankong.com%2Fsh%2Fj8%2FQJ8129672480.jpg%3Fx-oss-process%3Dstyle%2Fshow&refer=http%3A%2F%2Fdpic.tiankong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=e3bbaf5dfa465b8bc6f5bac3f836904e');
INSERT INTO good
VALUES (4, 'crab1', 10, 100, 'crab', 10, 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4196473987,741252673&fm=26&gp=0.jpg', 1, now(), now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%2Fimages%2F20170722%2F1500703140_22719_3.jpg&refer=http%3A%2F%2Fimage.cnpp.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=7f29be1bae61c9e53833b0cbf8816652', 'hihi', 'hi', 5, '2001', '5','3', now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdpic.tiankong.com%2Fsh%2Fj8%2FQJ8129672480.jpg%3Fx-oss-process%3Dstyle%2Fshow&refer=http%3A%2F%2Fdpic.tiankong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=e3bbaf5dfa465b8bc6f5bac3f836904e');
INSERT INTO good
VALUES (5, 'crab2', 10, 100, 'crab', 10, 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1493419376,4165950819&fm=26&gp=0.jpg', 1, now(), now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%2Fimages%2F20170722%2F1500703140_22719_3.jpg&refer=http%3A%2F%2Fimage.cnpp.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=7f29be1bae61c9e53833b0cbf8816652', 'hihi', 'hi', 5, '2001', '5','3', now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdpic.tiankong.com%2Fsh%2Fj8%2FQJ8129672480.jpg%3Fx-oss-process%3Dstyle%2Fshow&refer=http%3A%2F%2Fdpic.tiankong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=e3bbaf5dfa465b8bc6f5bac3f836904e');
INSERT INTO good
VALUES (6, 'crab3', 10, 100, 'crab', 10, 'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4082667852,1179671143&fm=26&gp=0.jpg', 1, now(), now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%2Fimages%2F20170722%2F1500703140_22719_3.jpg&refer=http%3A%2F%2Fimage.cnpp.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=7f29be1bae61c9e53833b0cbf8816652', 'hihi', 'hi', 5, '2001', '5','3', now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdpic.tiankong.com%2Fsh%2Fj8%2FQJ8129672480.jpg%3Fx-oss-process%3Dstyle%2Fshow&refer=http%3A%2F%2Fdpic.tiankong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=e3bbaf5dfa465b8bc6f5bac3f836904e');
INSERT INTO good
VALUES (7, 'shrimp1', 10, 100, 'shrimp', 10, 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.cutefoods.com%2Fwp-content%2Fuploads%2F2015%2F11%2Fsell_shrimp.jpg&refer=http%3A%2F%2Fwww.cutefoods.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1620710951&t=a526a5565328e253f04f38339a1efca0', 1, now(), now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%2Fimages%2F20170722%2F1500703140_22719_3.jpg&refer=http%3A%2F%2Fimage.cnpp.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=7f29be1bae61c9e53833b0cbf8816652', 'hihi', 'hi', 5, '2001', '5','3', now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdpic.tiankong.com%2Fsh%2Fj8%2FQJ8129672480.jpg%3Fx-oss-process%3Dstyle%2Fshow&refer=http%3A%2F%2Fdpic.tiankong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=e3bbaf5dfa465b8bc6f5bac3f836904e');
INSERT INTO good
VALUES (8, 'shrimp2', 10, 100, 'shrimp', 10, 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.airfrance.am%2FAM%2Fcommon%2Fcommon%2Fimg%2Ftbaf%2Fnews%2FTPE%2Ftrois-experiences-nocturnes-insolites-pour-votre-sejour-a-taipei%2Fbrochette-crevette-taipei-insolite.jpg&refer=http%3A%2F%2Fwww.airfrance.am&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1620710963&t=cdeeb18d26f96a69c0dfcb85ac29498b', 1, now(), now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%2Fimages%2F20170722%2F1500703140_22719_3.jpg&refer=http%3A%2F%2Fimage.cnpp.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=7f29be1bae61c9e53833b0cbf8816652', 'hihi', 'hi', 5, '2001', '5','3', now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdpic.tiankong.com%2Fsh%2Fj8%2FQJ8129672480.jpg%3Fx-oss-process%3Dstyle%2Fshow&refer=http%3A%2F%2Fdpic.tiankong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=e3bbaf5dfa465b8bc6f5bac3f836904e');
INSERT INTO good
VALUES (9, 'shrimp3', 10, 100, 'shrimp', 10, 'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2785278829,2022407696&fm=26&gp=0.jpg', 1, now(), now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage.cnpp.cn%2Fupload%2Fimages%2F20170722%2F1500703140_22719_3.jpg&refer=http%3A%2F%2Fimage.cnpp.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=7f29be1bae61c9e53833b0cbf8816652', 'hihi', 'hi', 5, '2001', '5','3', now(), 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdpic.tiankong.com%2Fsh%2Fj8%2FQJ8129672480.jpg%3Fx-oss-process%3Dstyle%2Fshow&refer=http%3A%2F%2Fdpic.tiankong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622620505&t=e3bbaf5dfa465b8bc6f5bac3f836904e');




INSERT INTO swiper_img VALUES (1, 'fewfawfewafeawf');
INSERT INTO swiper_img VALUES (2, 'grfgregrege');