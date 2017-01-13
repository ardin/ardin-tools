##
## Aliases
##

#
# Aliases / System
# 
alias s="ssh"

#
# Aliases / Docker
# 
alias docker-clean="docker rm -v `docker ps -a -q -f status=exited`  ; docker rmi `docker images -f "dangling=true" -q`"


##
## Functions
##

function ssl-sni()
{
        [[ -z $1 ]] && echo " * Syntax: $FUNCNAME site:port" && return 1
        printf "\n" | openssl s_client -connect $1 2>&1 | openssl x509 -text -noout | grep DNS
}

function ssl-dates()
{
        [[ -z $1 ]] && echo " * Syntax: $FUNCNAME site:port" && return 1
        printf "\n" | openssl s_client -connect $1 2>&1 | openssl x509 -dates -noout
}

