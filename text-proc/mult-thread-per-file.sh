#!/bin/bash
letters=$(cat "$1" | tr -d '\n')
inf="$2"
np="$3"
bs=$(basename "$inf")

numbProcess=${np}
numbLine=$(wc -l "${inf}" | cut -d ' ' -f1)
numbLinePerThread=`expr ${numbLine} / ${numbProcess}` # FIXME: has to be floats
echo ${inf} ${numbProcess} ${numbLinePerThread} ${numbLine}
n=1;
s=1; e=$numbLinePerThread;
while [[ $e -le ${numbLine} ]]; do # FIXME: Cause of numbLinePerThread is int
	# Single process
	sed -n "$s, $e p" "$inf" \
		| sed "s/[&#%]\+\S\+//gI;
			s/^([^()]*)//g;
			s/^\[[^\[\]]*\]//g;
			s/^[^${letters}\$\'\"]\s*//gI;
			s/[^${letters}\.\'\"!?;,0-9%\$]$//gI;
			/^\S*$/d
			/^\s*$/d
			/^\S*\s\S*$/d" \
		| sed "s/^[^${letters}\$\'\"]\s*//gI" \
		| egrep --ignore-case "^[ \s${letters}0-9,\.\?\!:;()\/\\\-\_\"\']*$" \
		| uniq > "${bs}.good.$n"  &
	# Update range of infile
	s=`expr $s + ${numbLinePerThread}`
	e=`expr $e + ${numbLinePerThread}`
	if [[ $s -ge ${numbLine} ]]; then
		break;
	fi
	if [[ $e -gt ${numbLine} ]]; then
		e=${numbLine}
	fi
	n=`expr $n + 1`
done
wait
echo "Merging temporal files"
cat "${bs}.good."[0-9]* > "${bs}.good"
rm -f "${bs}.good."[0-9]*