#!/bin/bash

#http://pastebin.com/tfxYjvLr
firstway()
{
    echo "What version of Pligg would you like to use?";
    echo "Examples: 1.0.4, 1.0.3, or 1.0.2";
    read version
    echo "Beginning SVN Installation...";
    svn co https://pligg.svn.sourceforge.net/svnroot/pligg/tags/$version/ .
    echo "SVN Files Added!";

    echo "Renaming Files...";
    mv languages/lang_english.conf.default languages/lang_english.conf
    mv languages/lang_arabic.conf.default languages/lang_arabic.conf
    mv languages/lang_chinese_simplified.conf.default languages/lang_chinese_simplified.conf
    mv languages/lang_german.conf.default languages/lang_german.conf
    mv languages/lang_italian.conf.default languages/lang_italian.conf
    mv languages/lang_russian.conf.default languages/lang_russian.conf
    mv languages/lang_thai.conf.default languages/lang_thai.conf
    mv languages/lang_turkmen.conf.default languages/lang_turkmen.conf
    mv bannedips.txt.default bannedips.txt
    mv settings.php.default settings.php
    mv local-antispam.txt.default local-antispam.txt
    mv libs/dbconnect.php.default libs/dbconnect.php
# mv htaccess.default .htaccess
    echo "File Renaming Complete!";

    echo "Setting CHMOD Permissions...";
    chmod 777 cache
    chmod 777 cache/admin_c
    chmod 777 cache/templates_c
    chmod 777 admin/backup
    chmod 777 avatars/groups_uploaded
    chmod 777 avatars/user_uploaded
    chmod 777 languages
    chmod 777 languages/installer_lang.php
    chmod 777 languages/installer_lang_default.php
    chmod 777 languages/lang_english.conf
    chmod 777 languages/lang_arabic.conf
    chmod 777 languages/lang_chinese_simplified.conf
    chmod 777 languages/lang_german.conf
    chmod 777 languages/lang_italian.conf
    chmod 777 languages/lang_russian.conf
    chmod 777 languages/lang_thai.conf
    chmod 777 languages/lang_turkmen.conf
    chmod 666 libs/dbconnect.php
    chmod 666 bannedips.txt
    chmod 666 settings.php
    chmod 666 local-antispam.txt
    echo "CHMOD Permissions Complete!";

    echo "SVN Installation Complete!!!";
}





second_say()
{
# needs newer version of perl-compatible regular expressions
#pacman -S pcre
#
#sql1="drop database if exists $wp_db_name; create database $wp_db_name;"
#sql2="GRANT ALL PRIVILEGES ON $wp_db_name.* TO '$wp_db_user'@'localhost' IDENTIFIED BY '$wp_db_pass';"
#sql_backup=$wp_stage_dir/wp-content/wp-backup.sql
#zip_arch=$tmp_dir/wp-arch.zip
#sql="$sql1 $sql2"
#grant all privileges on pligg1.* to 'pligg1'@'localhost' identified by '49niners'
#mysql -u root -p$db_pass -e "$sql"

    cd /home/example/www/
    rm -rf ./pligg
    unzip ./fixpligg.zip
    cd ./pligg
    mv ./settings.php.default ./settings.php
    mv ./libs/dbconnect.php.default ./libs/dbconnect.php
    chmod -R 777 ./languages
    chmod 755 ./admin/backup/
    chmod 755 ./avatars/groups_uploaded/
    chmod 755 ./avatars/user_uploaded/
    chmod 777 ./cache/
    chmod 755 ./cache/admin_c/
    chmod 777 ./cache/templates_c/
    chmod 666 ./libs/dbconnect.php
    chmod 666 ./settings.php
    chmod -R 777 ./templates/


#Open /install/index.php in your web browser. If you are reading this document after you uploaded it to your server, click on the install link at the top of the page.
##Select a language from the list.
##Fill out your database name, username, password, host, and your desired table prefix.
##Create an admin account. Please write down the login credentials for future reference.
##Make sure there are no error messages! If you see an error message, or if installation fails, create a new thread on the Pligg forums
#Delete your /install folder.
#CHMOD 644 libs/dbconnect.php
#Open /index.php
#Log in to the admin account using the credentials generated during the install process.
#Log in to the admin panel ( /admin ).
#Configure your Pligg site to your liking. Don't forget to use the Modify Language page to change your site's name.
}
