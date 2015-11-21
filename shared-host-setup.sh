#useradd -m -u 1001 meta1
#usermod -G wpress,http wpress

#USERX=zigler
SQLPASS=some_pass

do_unix_user() {
    USERX=$1
    useradd -m "$USERX"
    usermod -G "$USERX",http "$USERX"
    chmod 755 "/home/$USERX"
    chown "$USERX:$USERX" "/home/$USERX"
    mkdir "/home/$USERX/www"
    chown "$USERX:$USERX" "/home/$USERX/www"
}

do_mysql_user() {
    USERX=$1
    SQL1="drop database if exists $USERX;"
    SQL2="create database $USERX;"
    SQL3="GRANT ALL PRIVILEGES ON $USERX.* TO '$USERX'@'localhost' IDENTIFIED BY '$SQLPASS';"
    mysql -u root -p -e "$SQL1 $SQL2 $SQL3"
}

go() {
    do_unix_user $1
    do_mysql_user $1
}

go example1
go example2
go example3
