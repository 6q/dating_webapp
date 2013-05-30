<?php

	/*
	|| #################################################################### ||
	|| #                             ArrowChat                            # ||
	|| # ---------------------------------------------------------------- # ||
	|| #    Copyright �2010-2012 ArrowSuites LLC. All Rights Reserved.    # ||
	|| # This file may not be redistributed in whole or significant part. # ||
	|| # ---------------- ARROWCHAT IS NOT FREE SOFTWARE ---------------- # ||
	|| #   http://www.arrowchat.com | http://www.arrowchat.com/license/   # ||
	|| #################################################################### ||
	*/

	// The intial configuration settings for ArrowChat
	
	$sql_ary = array(
		"INSERT INTO arrowchat_themes (id, folder, name, active, update_link, version, [default]) 
			VALUES (1, 'new_facebook_full', 'New Facebook Full', '1' ,'http://www.arrowchat.com/updatecheck.php?id=8', '3.3', '1')",

		"INSERT INTO arrowchat_smilies (id, name, code) 
			VALUES (1, 'smiley', ':)'), (2, 'smiley-mad', '>:('), (3, 'smiley-lol', ':D'), (4, 'smiley-wink', ';)'), (5, 'smiley-surprise', ':o'), (6, 'smiley-cool', '8)'), (7, 'smiley-neutral', ':|'), (8, 'smiley-cry', ':''('), (9, 'smiley-razz', ':p'), (10, 'smiley-confuse', ':s'), (11, 'smiley', ':-)'), (12, 'smiley-sad', ':-('), (13, 'smiley-wink', ';-)'), (14, 'smiley-surprise', ':-o'), (15, 'smiley-cool', '8-)'), (16, 'smiley-neutral', ':-|'), (17, 'smiley-razz', ':-p'), (18, 'smiley-confuse', ':-s'), (20, 'smiley-sad', ':(')",
			
		"INSERT INTO arrowchat_notifications_markup (id, name, type, markup) 
			VALUES (1, 'Private Messages', 1, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_message_icon.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has sent you a new message.<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (2, 'Friend Requests', 2, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_friend_icon.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has sent you a friend request.<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (3, 'Wall Post', 3, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_wall_post.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has wrote on your wall.<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (4, 'Event Invite', 4, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_event.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has invited you to an event.<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (5, 'Group Invite', 5, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_group.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has invited you to a group.<br />	<div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (6, 'Birthday', 6, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_birthday.png\" class=\"arrowchat_notification_icon\" />It is <a href=\"#\">{author_name}</a>\'s birthday!<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (7, 'Comment', 7, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_comment.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has left you a comment.<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (8, 'Reply', 8, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_reply.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has replied to you.<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (9, 'Like Post', 9, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_like.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has liked your post.<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (10, 'Like Comment', 10, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_like.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has liked your comment.<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>'), (11, 'Like Photo', 11, '<div class=\"arrowchat_notification_box arrowchat_blue_link\"><img src=\"".$_SESSION['config_path']."themes/new_facebook_full/images/icons/notification_like.png\" class=\"arrowchat_notification_icon\" /><a href=\"#\">{author_name}</a> has liked your photo.<br /><div class=\"arrowchat_received\">Received {longago}</div></div><div class=\"arrowchat_notifications_divider\"></div>')",

		"INSERT INTO arrowchat_config (config_name, config_value, is_dynamic) 
			VALUES ('theme', 'new_facebook_full', 0), ('base_url', '".$_SESSION['config_path']."', 0), ('online_timeout', '120', 0), ('disable_smilies', '0', 0), ('auto_popup_chatbox', '1', 0), ('heart_beat', '3', 0), ('language', 'en', 0), ('idle_time', '3', 0), ('install_time', '".time()."', 0), ('chatrooms_on', '0', 0), ('notifications_on', '0', 0), ('hide_bar_on', '1', 0), ('applications_on', '0', 0), ('popout_chat_on', '1', 0), ('theme_change_on', '0', 0), ('disable_avatars', '0', 0), ('disable_buddy_list', '".$disable_buddy_list."', 0), ('search_number', '10', 0), ('chat_maintenance', '0', 0), ('announcement', '', 0), ('admin_chat_all', '0', 0), ('admin_view_maintenance', '0', 0), ('user_chatrooms', '0', 0), ('user_chatrooms_flood', '10', 0), ('user_chatrooms_length', '30', 0), ('video_chat', '1', 0), ('us_time', '1', 0), ('file_transfer_on', '0', 0), ('width_applications', '16', 0), ('width_buddy_list', '189', 0), ('width_chatrooms', '16', 0), ('buddy_list_heart_beat', '60', 0), ('applications_guests', '1', 0), ('bar_fixed', '0', 0), ('bar_fixed_alignment', 'center', 0), ('bar_fixed_width', '900', 0), ('bar_padding', '15', 0), ('chatroom_auto_join', '0', 0), ('chatroom_history_length', '60', 0), ('disable_arrowchat', '0', 0), ('enable_mobile', '1', 0), ('guests_can_chat', '".$guests_can_chat."', 0), ('guests_can_view', '".$guests_can_view."', 0), ('guests_chat_with', '1', 0), ('push_on', '".$push_on."', 0), ('push_publish', '".$_SESSION['publish_key']."', 0), ('push_subscribe', '".$_SESSION['subscribe_key']."', 0), ('show_full_username', '0', 0), ('users_chat_with', '3', 0), ('hide_admins_buddylist', '0', 0), ('show_bar_links_right', '0', 0), ('enable_chat_animations', '1', 0), ('hide_applications_menu', '0', 0), ('guest_name_change', '1', '0'), ('guest_name_duplicates', '0', '0'), ('guest_name_bad_words', 'fuck,cunt,nigger,shit,admin,administrator,mod,moderator,support', '0')",
			
		"INSERT INTO arrowchat_admin (id, username, password, email) 
			VALUES (1, '".$_SESSION['admin_username']."', '".md5($_SESSION['admin_password'])."', '".$_SESSION['admin_email']."')"
	);
?>