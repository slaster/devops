# Configures a debian instance and installs a wordpress instance

SQLPASS=password
HTTPWWW_GROUP=www-data

curl_wp() {

    conf_params1='admin_email=user2%40host2.com&blog_public=1&Submit=Install%20WordPress'
    conf_params2='&weblog_title=My%20Title&user_name=admin&admin_password=password&admin_password2=password'
    conf_params="$conf_params1$conf_params2"
    wp_conf_url="http://localhost/new/wp/wp-admin/install.php?step=2"

    curl -s -d "$conf_params" "$wp_conf_url" > /tmp/foo
}

config_wp() {
    cd $1
    wp_db_name=example
    wp_db_user=example
    wp_db_pass=examplemysql
    wp_db_prefix=wp_

    # Create the wp-config.php file
    sed -e "s/database_name_here/$wp_db_name/" \
        -e "s/username_here/$wp_db_user/" \
        -e "s/password_here/$wp_db_pass/" \
        -e "s/wp_/$wp_db_prefix/" \
        -e "/^define.*unique/d" \
        -e "/Happy/ adefine('WP_ALLOW_MULTISITE', true);" \
        wp-config-sample.php > wp-config.php
}




update_php() {
    cp /etc/php5/apache2/php.ini /root/original-php.ini
    sed 's/;extension=gd.so/extension=gd.so/' /root/original-php.ini > /root/new-php.ini
    sed 's/;extension=curl.so/extension=curl.so/' /root/original-php.ini > /root/new-php.ini
    sed 's/;extension=mysql.so/extension=mysql.so/' /root/original-php.ini > /root/new-php.ini
    cp /root/new-php.ini /etc/php5/apache2/php.ini
    #echo "<?php phpinfo(); ?>" >> /srv/http/index.php
}

do_debian_updates() {
    apt-get -y dist-upgrade
    apt-get -y update
    apt-get -y install dnsutils sudo zip unzip curl
    apt-get -y install mysql-server 
    apt-get -y install apache2 apache2-utils apache2-mpm-itk libapache2-mod-php5 
    apt-get -y install php5 php-pear php5-suhosin php5-gd php5-memcache php5-mcrypt php5-gmp php5-mysql
}

do_unix_user() {
    USERX=$1
    useradd -m "$USERX"
    usermod -G "$USERX",$HTTPWWW_GROUP "$USERX"
    chmod 755 "/home/$USERX"
    chown "$USERX:$USERX" "/home/$USERX"
    mkdir "/home/$USERX/www"
    chown "$USERX:$USERX" "/home/$USERX/www"
}

do_mysql_user() {
    USERX=$1
    salt="mysql"
    USERPASS="$USERX$salt"
    SQL1="drop database if exists $USERX;"
    SQL2="create database $USERX;"
    SQL3="GRANT ALL PRIVILEGES ON $USERX.* TO '$USERX'@'localhost' IDENTIFIED BY '$USERPASS';"
    echo $SQL3
    mysql -u root -p$SQLPASS -e "$SQL1 $SQL2 $SQL3"
}

do_web_user() {
    mkdir /home/$1/www
}

go() {
    do_unix_user $1
    do_mysql_user $1
    do_web_user $1
}

do_debian_updates
go example.com
update_php
do_mysql_user example
config_wp /home/example/www/example
