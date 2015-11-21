update_pacman_mirrors() {
    cp /etc/pacman.d/mirrorlist /root/original-mirrorlist
    sed '/ United States/,/Vietnam/ s/#Server/Server/' /root/original-mirrorlist > /etc/pacman.d/mirrorlist
}

update_lamps() {
    cp /etc/php/php.ini /root/original-php.ini
    cp /etc/httpd/conf/httpd.conf /root/original-httpd.conf
    touch /root/custom.conf
    sed 's/;extension=gd.so/extension=gd.so/' /root/original-php.ini > /etc/php/php.ini
    sed -e '/LoadModule rewrite_module modules\/mod_rewrite.so/,/IfModule/ s/^$/LoadModule php5_module modules\/libphp5.so/' -e '/Include conf\/extra\/httpd-default.conf/,/# Secure (SSL\/TLS) connections/ s/^$/Include conf\/extra\/php5_module.conf/' /root/original-httpd.conf > /etc/httpd/conf/httpd.conf
    echo "Include /root/custom.conf" >> /etc/httpd/conf/httpd.conf
    echo "<?php phpinfo(); ?>" >> /srv/http/index.php
}

do_pacman_update() {
    pacman --noconfirm -S pacman
    pacman --noconfirm -S lynx git rlwrap zip unzip apache php-apache php-gd php-curl php-mcrypt php-xsl php-sqlite php-memcache mysql
    pacman --noconfirm -Syy
    pacman --noconfirm -Syu
}

do_mysqld_security() {
    /etc/rc.d/mysqld start
    echo "UPDATE mysql.user SET Password=PASSWORD('PASSWORD') WHERE User='root';" > /tmp/sql.sql
    echo "DELETE FROM mysql.user WHERE User='';" >> /tmp/sql.sql
    echo "DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';" >> /tmp/sql.sql
    echo "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" >> /tmp/sql.sql
    echo "DROP DATABASE test;" >> /tmp/sql.sql
    echo "FLUSH PRIVILEGES;" >> /tmp/sql.sql
    mysql -u root < /tmp/sql.sql
    rm /tmp/sql.sql
    /etc/rc.d/mysqld stop
}


########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
#MAIN
update_pacman_mirrors
do_pacman_update
update_lamps
do_mysqld_security
