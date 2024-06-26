#!/bin/bash  
USER=bak
PASSWD=123456
IO_SQL_STATUS=$(mysql -u$USER -p$PASSWD -e  show slave statusG  |awk -F:  /Slave_.*_Running/{gsub(": ",":");print $0} )
for i in $IO_SQL_STATUS; do
    THREAD_STATUS_NAME=${i%:*}
    THREAD_STATUS=${i#*:}
    if [ "$THREAD_STATUS" != "Yes" ]; then
        echo "Error: MySQL Master-Slave $THREAD_STATUS_NAME status is $THREAD_STATUS!"
    fi
done
