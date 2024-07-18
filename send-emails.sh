#!/bin/bash

#ADDRS=emails-test.csv
ADDRS=private/ramics-emails.csv
#ADDRS=/tmp/emails-1.csv

FROM=fahrenberg@gmail.com

EMAILCONT=cfsc.txt

#SUBJECT='CfP: Relational and Algebraic Methods in Computer Science, RAMiCS 2024, Prague'
#SUBJECT='3rd CfP & Deadline Extension: RAMiCS 2024'
SUBJECT='Call for short contributions: RAMiCS 2024'

#TMPDIR=$(mktemp -d)
TMPDIR=/tmp

echo "Sending emails to all people in $ADDRS"
#ramics-emails.csv: 

while read -r LINE; do
#for LINE in $(cat $ADDRS); do
    #echo $LINE
    LAST=$(echo $LINE|awk -F, '{print $1}')
    FIRST=$(echo $LINE|awk -F, '{print $2}')
    EMAIL=$(echo $LINE|awk -F, '{print $3}')
    echo "Sending to $FIRST $LAST at $EMAIL"
    echo "From: $FROM" > $TMPDIR/email.txt
    echo "To: $EMAIL" >> $TMPDIR/email.txt
    echo "Subject: $SUBJECT" >> $TMPDIR/email.txt
    echo "" >> $TMPDIR/email.txt
    #echo "Dear $FIRST $LAST," >> $TMPDIR/email.txt
    echo "" >> $TMPDIR/email.txt
    cat $EMAILCONT >> $TMPDIR/email.txt
    cat $TMPDIR/email.txt | ssmtp $EMAIL
    sleep 1 #otherwise, too fast for gmail :)
#done
done < $ADDRS    

echo 'Done'
