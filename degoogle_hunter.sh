#!/bin/bash
hostname=$1
target=${hostname%%.*}

declare -A dorks

dorks["# Other 3rd parties sites"]="site:gitter.im | site:papaly.com | site:productforums.google.com | site:coggle.it | site:replt.it | site:ycombinator.com | site:libraries.io | site:npm.runkit.com | site:npmjs.com | site:scribd.com \"$target\""
dorks["# Code share sites"]="site:sharecode.io | site:controlc.com | site:codepad.co |site:ideone.com | site:codebeautify.org | site:jsdelivr.com | site:codeshare.io | site:codepen.io | site:repl.it | site:jsfiddle.net \"$target\""
dorks["# GitLab/GitHub/Bitbucket"]="site:github.com | site:gitlab.com | site:bitbucket.org \"$target\""
dorks["# Stackoverflow"]="site:stackoverflow.com \"$1\""
dorks["# Project management sites"]="site:trello.com | site:*.atlassian.net \"$target\""
dorks["# Pastebin-like sites"]="site:justpaste.it | site:heypasteit.com | site:pastebin.com \"$target\""
dorks["# Config files"]="site:$1 ext:xml | ext:conf | ext:cnf | ext:reg | ext:inf | ext:rdp | ext:cfg | ext:txt | ext:ora | ext:env | ext:ini"
dorks["# Database files"]="site:$1 ext:sql | ext:dbf | ext:mdb"
dorks["# Backup files"]="site:$1 ext:bkf | ext:bkp | ext:bak | ext:old | ext:backup"
dorks["# .git folder"]="inurl:\"/.git\" $1 -github"
dorks["# Exposed documents"]="site:$1 ext:doc | ext:docx | ext:odt | ext:pdf | ext:rtf | ext:sxw | ext:psw | ext:ppt | ext:pptx | ext:pps | ext:csv"
dorks["# Other files"]="site:$1 intitle:index.of | ext:log | ext:php intitle:phpinfo \"published by the PHP Group\" | inurl:shell | inurl:backdoor | inurl:wso | inurl:cmd | shadow | passwd | boot.ini | inurl:backdoor | inurl:readme | inurl:license | inurl:install | inurl:setup | inurl:config | inurl:\"/phpinfo.php\" | inurl:\".htaccess\" | ext:swf"
dorks["# SQL errors"]="site:$1 intext:\"sql syntax near\" | intext:\"syntax error has occurred\" | intext:\"incorrect syntax near\" | intext:\"unexpected end of SQL command\" | intext:\"Warning: mysql_connect()\" | intext:\"Warning: mysql_query()\" | intext:\"Warning: pg_connect()\""
dorks["# PHP errors"]="site:$1 \"PHP Parse error\" | \"PHP Warning\" | \"PHP Error\""
dorks["# Login pages"]="site:$1 inurl:signup | inurl:register | intitle:Signup"
dorks["# Open redirects"]="site:$1 inurl:redir | inurl:url | inurl:redirect | inurl:return | inurl:src=http | inurl:r=http"
dorks["# Apache Struts RCE"]="site:$1 ext:action | ext:struts | ext:do"
dorks["# Linkedin employees"]="site:linkedin.com employees $1"
dorks["# Wordpress files"]="site:$1 inurl:wp-content | inurl:wp-includes"
dorks["# Subdomains"]="site:*.$1"
dorks["# Sub-subdomains"]="site:*.*.$1"
dorks["# Cloud buckets S3/GCP"]="site:.s3.amazonaws.com | site:storage.googleapis.com | site:amazonaws.com \"$target\""
dorks["# Traefik"]="intitle:traefik inurl:8080/dashboard \"$target\""
dorks["# Jenkins"]="intitle:\"Dashboard [Jenkins]\" \"$target\""

for c in "${!dorks[@]}"; do
    printf "\n\e[32m"%s"\e[0m\n" "$c" && python3 degoogle.py -j "${dorks[$c]}"
done
