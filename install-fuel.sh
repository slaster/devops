tmpdir=/tmp/example
archdir=/home/sarchives/softwarearchives/Software/archives
fuelname=daylightstudio-FUEL-CMS-v0.9.3-0-gbe4c43d
fuelnameunzipped=daylightstudio-FUEL-CMS-67011ac
fuelarch="$archdir/$fuelname.zip"

appname=example

wwwdir=/var/www/new


htaccess_install()
{
    htaccesscontent="<IfModule mod_rewrite.c>\n
    RewriteEngine On\n
    RewriteCond %{REQUEST_URI} ^system.*\n
    RewriteRule ^(.*)$ /index.php?/\$1 [L]\n
    RewriteCond %{REQUEST_URI} ^application.*\n
    RewriteRule ^(.*)$ /index.php?/\$1 [L]\n
    RewriteCond %{REQUEST_FILENAME} !-f\n
    RewriteCond %{REQUEST_FILENAME} !-d\n
    RewriteRule ^(.*)$ index.php?/\$1 [L]\n
</IfModule>\n
\n
<IfModule !mod_rewrite.c>\n
    ErrorDocument 404 /index.php\n
</IfModule>\n";
    echo $htaccesscontent > $tmpdir/$appname/.htaccess

}


base_install()
{
    mkdir -p $tmpdir
    unzip -qq $fuelarch -d $tmpdir
    mv $tmpdir/$fuelnameunzipped $tmpdir/$appname
}

fix_config()
{

    configpath="$tmpdir/$appname/fuel/application/config"

    cp $configpath/database.php $tmpdir/
    sed -e "s/username'] = ''/username'] = 'root'/" \
        -e "s/password'] = ''/password'] = 'password'/" \
        -e "s/database'] = ''/database'] = 'fuel1'/" \
        $tmpdir/database.php > $configpath/database.php

    cp $configpath/MY_fuel.php $tmpdir/
    sed -e "s/fuel_mode'] = 'views'/fuel_mode'] = 'auto'/" \
        -e "s/admin_enabled'] = FALSE/admin_enabled'] = 'TRUE'/" \
        $tmpdir/MY_fuel.php > $configpath/MY_fuel.php

    
}

db_install()
{
    installsql="$tmpdir/$appname/fuel/install/widgicorp.sql"
    #password = password
    mysql -u root -p -e "drop database if exists fuel1; create database fuel1;"
    mysql -u root -p fuel1 < $installsql

}


stage_app()
{
    sudo mv $tmpdir/$appname $wwwdir

    sudo chgrp www-data "$wwwdir/$appname/fuel/application/cache"
    sudo chgrp www-data "$wwwdir/$appname/fuel/application/cache/dwoo"
    sudo chgrp www-data "$wwwdir/$appname/fuel/application/cache/dwoo/compiled"
    sudo chgrp www-data "$wwwdir/$appname/assets/images"

    chmod g+w "$wwwdir/$appname/fuel/application/cache"
    chmod g+w "$wwwdir/$appname/fuel/application/cache/dwoo"
    chmod g+w "$wwwdir/$appname/fuel/application/cache/dwoo/compiled"
    chmod g+w "$wwwdir/$appname/assets/images"

}

base_install
htaccess_install
fix_config
db_install
stage_app

