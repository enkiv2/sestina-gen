#!/usr/bin/env zsh

source=$1
words=$(cat $source | sed 's/^.* \([a-zA-Z][a-zA-Z]*\)$/\1/;s/[^A-Za-z]//g' | grep . | sort | uniq -c | awk '{if ($1>6) print $2 }' | sort -R | head -n 6)
(echo $words | while read word ; do
	grep ' '"$word"'$' $source | sort -R | head -n 6 
done ) | awk '{lines[line%6]=lines[line%6] $0 "\n" ; line++} END { for (i=0; i<6; i++) { print lines[i]; } }' | grep . | awk 'BEGIN { stanza=1; line=0 } { line++; if(line>6) { line=1; stanza++; for (l in chunks) { print chunks[l]; chunks[l]="" } }  chunks[stanza+line]=$0 } END { for (l in chunks) { print chunks[l] } }' | grep . | awk '{line++; print ; if((line)%6==0) { print "" } } '

