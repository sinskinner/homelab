#!/bin/vbash
if [ "$(id -g -n)" != 'vyattacfg' ] ; then
    exec sg vyattacfg -c "/bin/vbash $(readlink -f $0) $@"
fi
source /opt/vyatta/etc/functions/script-template
configure
discard
load /tmp/config.txt
statusCode=$?
if [ $statusCode -ne 0 ]; then
    exit $statusCode
fi
commit
statusCode=$?
if [ $statusCode -ne 0 ]; then
    exit $statusCode
fi
save
