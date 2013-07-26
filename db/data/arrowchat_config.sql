/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50515
 Source Host           : localhost
 Source Database       : cellove_development

 Target Server Type    : MySQL
 Target Server Version : 50515
 File Encoding         : utf-8

 Date: 07/26/2013 23:32:53 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `arrowchat_admin`
-- ----------------------------
DROP TABLE IF EXISTS `arrowchat_admin`;
CREATE TABLE `arrowchat_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `arrowchat_admin`
-- ----------------------------
BEGIN;
INSERT INTO `arrowchat_admin` VALUES ('1', 'admin', '9ceb595da66b153a3db5fb22af83466a', 'info@cellove.com');
COMMIT;

-- ----------------------------
--  Table structure for `arrowchat_config`
-- ----------------------------
DROP TABLE IF EXISTS `arrowchat_config`;
CREATE TABLE `arrowchat_config` (
  `config_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `config_value` text COLLATE utf8_unicode_ci,
  `is_dynamic` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `config_name` (`config_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `arrowchat_config`
-- ----------------------------
BEGIN;
INSERT INTO `arrowchat_config` VALUES ('admin_chat_all', '1', '0'), ('admin_view_maintenance', '1', '0'), ('announcement', '', '0'), ('applications_on', '0', '0'), ('auto_popup_chatbox', '1', '0'), ('bar_fixed', '0', '0'), ('bar_fixed_alignment', 'center', '0'), ('bar_fixed_width', '900', '0'), ('bar_padding', '15', '0'), ('base_url', '/arrowchat/', '0'), ('buddy_list_heart_beat', '60', '0'), ('chat_display_type', '1', '0'), ('chat_maintenance', '0', '0'), ('chatroom_auto_join', '0', '0'), ('chatroom_history_length', '60', '0'), ('chatrooms_on', '0', '0'), ('disable_arrowchat', '0', '0'), ('disable_avatars', '0', '0'), ('disable_buddy_list', '1', '0'), ('disable_smilies', '0', '0'), ('enable_chat_animations', '1', '0'), ('enable_mobile', '1', '0'), ('file_transfer_on', '0', '0'), ('guest_name_bad_words', 'fuck,cunt,nigger,shit,admin,administrator,mod,moderator,support', '0'), ('guest_name_change', '1', '0'), ('guest_name_duplicates', '0', '0'), ('guests_can_chat', '0', '0'), ('guests_can_view', '0', '0'), ('guests_chat_with', '1', '0'), ('heart_beat', '3', '0'), ('hide_admins_buddylist', '0', '0'), ('hide_applications_menu', '0', '0'), ('hide_bar_on', '1', '0'), ('idle_time', '3', '0'), ('install_time', '', '0'), ('language', 'es', '0'), ('notifications_on', '1', '0'), ('online_timeout', '120', '0'), ('popout_chat_on', '1', '0'), ('push_on', '0', '0'), ('push_publish', '', '0'), ('push_secret', '', '0'), ('push_subscribe', '', '0'), ('search_number', '5', '0'), ('show_bar_links_right', '0', '0'), ('show_full_username', '0', '0'), ('theme', 'new_facebook_full', '0'), ('theme_change_on', '0', '0'), ('us_time', '1', '0'), ('user_chatrooms', '0', '0'), ('user_chatrooms_flood', '10', '0'), ('user_chatrooms_length', '30', '0'), ('users_chat_with', '3', '0'), ('video_chat', '1', '0'), ('width_applications', '16', '0'), ('width_buddy_list', '189', '0'), ('width_chatrooms', '16', '0');
COMMIT;

-- ----------------------------
--  Table structure for `arrowchat_smilies`
-- ----------------------------
DROP TABLE IF EXISTS `arrowchat_smilies`;
CREATE TABLE `arrowchat_smilies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `arrowchat_smilies`
-- ----------------------------
BEGIN;
INSERT INTO `arrowchat_smilies` VALUES ('1', 'smiley-confuse', ':S'), ('3', 'smiley-cool', '8)'), ('4', 'smiley-cry', ':_('), ('5', 'smiley-lol', ':D'), ('6', 'smiley-mad', '>:('), ('7', 'smiley-neutral', ':|'), ('8', 'smiley-razz', ':p'), ('9', 'smiley-sad', ':('), ('10', 'smiley-surprise', ':O'), ('11', 'smiley-wink', ';)'), ('12', 'smiley', ':)');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
