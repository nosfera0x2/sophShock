#!/usr/local/bin/bash
echo "Content-type: text/html"
echo ""
echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Shocking News!</title>'
echo '</head>'
echo '<body>'
echo '<h1>Dad Jokes: On Demand</h1><p>'
echo 'Get Dad Jokes Using Bash!<p>'
curl https://icanhazdadjoke.com
echo '</body>'
echo '</html>'
exit 0
