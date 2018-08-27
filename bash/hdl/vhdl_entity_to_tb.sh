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

## ---------- Start
cat ~/.vim/header/_.vhdl
echo ""
grep --ignore-case "^library"  "${inf}"
grep --ignore-case "^use"  "${inf}"
echo ""
echo "use std.textio.all;"
echo "use ieee.std_logic_textio.all;"
echo "use ieee.numeric_std.all;
use std.env.all;
"

echo "entity tb_${entity} is"
echo "end entity tb_${entity};"
echo ""

echo "architecture tb_${entity}_impl of tb_${entity} is"

dgen=$(echo "${entity_to_component}" | \
	awk 'BEGIN{IGNORECASE = 1};/^[\t ]*generic/,/^[\t ]*)[\t ]*;/' | \
	grep ":" | \
	sed 's/^\s*/    constant  /g;
		 s/$/;/g
		 s/;;/;/g'
	)
echo "    constant PERIOD : time := 10 ns;"
echo "${dgen}"
echo -e "$entity_to_component"  | sed 's/^/    /g'
# ---------- Signal declaration
vhdl_entity_to_signal.sh $@ | sed 's/^/    /g'

echo "begin

    s_clk <= not s_clk after PERIOD/2;
    s_rst <= '1' after 3 * PERIOD; "
vhdl_entity_to_dut.sh "$@" | sed 's/^/    /g'
vhdl_entity_to_readio.sh $@ | sed 's/^/    /g'
echo "end architecture tb_${entity}_impl;"

