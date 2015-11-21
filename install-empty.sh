appname=example
tmpdir="/tmp/$appname"
archdir=/home/sarchives/softwarearchives/Software/archives
archname=example.zip
wwwdir="/var/www/new"

#rm tmp dir
rm -rf $tmpdir

# unzip and rename
unzip -qq "$archdir/$archname" -d "$tmpdir"
mv "$tmpdir/$archname" "$tmpdir/$appname" 

#stage
mv "$tmpdir/$appname" "$wwwdir/" 

#rm -rf $tmpdir

