#########################################################################
# File Name: screen.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2016-12-07 23:17:51
#########################################################################
#!/bin/bash

cat > ~/.screenrc << EOF
# meetbill
# meetbill@163.com
hardstatus on
hardstatus alwayslastline
hardstatus string "%{= G}%-Lw%{= .Y}%50> %n*%f %t%{= G}%+Lw%< %{= G}%-=%D %c:%s %m/%d/%Y"

# 关闭screen的startup message
startup_message off

# 关闭闪屏
vbell off
autodetach on
msgwait 1
shell bash
termcapinfo xterm|xterms|xs|rxvt|urxvt|tila ti@:te@
EOF

