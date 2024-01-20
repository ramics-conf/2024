#!/bin/bash

ADDRS=emails-test.csv
#ADDRS=ramics-emails.csv

FROM=fahrenberg@gmail.com

EMAILCONT=cfp2.txt

SUBJECT='CfP: Relational and Algebraic Methods in Computer Science, RAMiCS 2024, Prague'

#TMPDIR=$(mktemp -d)
TMPDIR=/tmp

echo "Sending emails to all people in $ADDRS"
#ramics-emails.csv: 

for LINE in $(cat $ADDRS); do
    #echo $LINE
    FIRST=$(echo $LINE|awk -F, '{print $2}')
    EMAIL=$(echo $LINE|awk -F, '{print $3}')
    echo "Sending to $FIRST at $EMAIL"
    echo "From: $FROM" > $TMPDIR/email.txt
    echo "To: $EMAIL" >> $TMPDIR/email.txt
    echo "Subject: $SUBJECT" >> $TMPDIR/email.txt
    echo "" >> $TMPDIR/email.txt
    #echo "Dear $FIRST," >> $TMPDIR/email.txt
    echo "Dear colleague," >> $TMPDIR/email.txt
    echo "" >> $TMPDIR/email.txt
    cat $EMAILCONT >> $TMPDIR/email.txt
    cat $TMPDIR/email.txt | ssmtp $EMAIL
done

echo 'Done'
