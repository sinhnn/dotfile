################################################################################
# Project name   : Generate skenetop for an entity
# File name      : .local/bin/vhdl_tb.sh
# Created date   : Thu 13 Apr 2017 03:08:16 PM +07
# Author         : Ngoc-Sinh Nguyen
# Last modified  : Thu 13 Apr 2017 03:08:16 PM +07
# Guide          :
###############################################################################
#!/bin/bash
inf=$@
# Entity declare
entity_to_component="$(vhdl_entity_to_component.sh $@)"
entity=$(echo "$entity_to_component" | head --lines=1 | awk '{print $2}')
IFS=$'\n'
# Separate generic and port map


dgen=$(echo "${entity_to_component}" | \
	awk 'BEGIN{IGNORECASE = 1};/^[\t ]*generic/,/^[\t ]*)[\t ]*;/' | \
	sed 's/generic/generic map/Ig;
		s/:.*;/=> ,/g;
		s/:.*/=> /g;
		s/.*=>/&&/g;
		s/\s*=>\s*$//g;
		s/\s*=>\s*,$/,/g;
		s/)\s*;/)/g
	')

pgen=$(echo "${entity_to_component}" | \
	awk 'BEGIN{IGNORECASE = 1};/^[\t ]*port/,/^[\t ]*)[\t ]*;/' | \
	sed 's/port/port map/Ig;
		s/:.*;/=> ,/g;
		s/:.*/=> /g;
		s/.*=>/&&/g;
		s/\s*=>\s*$//g;
		s/\s*=>\s*,$/,/g;
		s/=>\s*/=> s_/g;
	')
echo ""
echo -e "DUT_${entity}: ${entity}"
echo "${dgen}"
echo "${pgen}"
echo ""

