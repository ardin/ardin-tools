##
## Aliases
##

alias s="ssh"
alias h="host"
alias docker-clean="docker rm -v `docker ps -a -q -f status=exited`  ; docker rmi `docker images -f "dangling=true" -q`"


##
## Functions
##

function ssl-san()
{
        [[ -z $1 ]] && echo " * Syntax: $FUNCNAME site:port" && return 1
        printf "\n" | openssl s_client -connect $1 2>&1 | openssl x509 -text -noout | grep DNS
}

function ssl-dates()
{
        [[ -z $1 ]] && echo " * Syntax: $FUNCNAME site:port" && return 1
        printf "\n" | openssl s_client -servername $(echo $1 | cut -f 1 -d ':') -connect $1 2>&1 | openssl x509 -dates -noout
}

function ssl-check-v3()
{
        [[ -z $1 ]] && echo " * Syntax: $FUNCNAME site:port" && return 1
        printf "HEAD / HTTP/1.0" | openssl s_client -connect $1 -ssl3 >/dev/null 2>&1
        [[ $? -eq 0 ]] && echo "enabled" || echo "disabled"
}

function grep-ip ()
{
        if [ -z $1 ]; then
                echo " * Syntax: $FUNCNAME filename"
        else
                perl -lne 'print $1 if /(\d+\.\d+\.\d+\.\d+)/' $1
        fi
}

function server-info()
{
    if [ -z $1 ] ; then
      echo " * Syntax: $FUNCNAME servername"
    else
        ssh $1 'hostname; echo -n "- HDD: "; df -hl / | grep -v Filesystem ; echo -n "- CPUs: "; cat /proc/cpuinfo  | grep ^processor | wc -l ; echo -n "- "; grep MemTotal /proc/meminfo ; echo ; '
    fi
}

function docker-enter ()
{
    CONTAINERS=`sudo docker ps -a | grep Up | awk '{ print $1" "$NF }' | xargs`;
    echo $CONTAINERS;
    ID=`dialog --title " VM Configuration " --stdout --menu "Select container" 22 70 16 $CONTAINERS`;
    sudo docker exec -t -i $ID /bin/bash
}

function http-keepalive-test()
{
        echo "Checking: ${1}";
        time printf "GET / HTTP/1.1\r\nHost: ${1}\r\nConnection: Keep-alive\r\n\r\n" | nc ${1} 80;
}

function change-root-password()
{
        if [ -z $1 ] ; then
                echo "Syntax: $FUNCNAME servername";

        else
                PASS=`head -c 500 /dev/urandom | tr -dc a-z0-9 | head -c 15`;
                echo "Setting password for $1"
                ssh -t ${1} "echo -e \"${PASS}\n${PASS}\" | passwd root" && echo "server: root@${1} , new password: ${PASS}" || echo "server: root@${1}, FAIL !";
        fi
}

function shadow-pass()
{
        openssl passwd -1 -salt xyz ${1}
}

function ardin-tools()
{
	echo "ardin-tools: installed";
}

function server-deinstallation()
{
    [[ -z $1 ]] && echo " * Syntax: $FUNCNAME server" && return 1

    echo "Creating directory $1"
    mkdir $1 && cd $1 || exit 2

    echo "Copying /etc .."
    ssh $1 'cd /; tar czf - etc ' | cat - > etc.tgz

    echo "Copying /home .."
    ssh $1 'cd /; tar czf - home ' | cat - > home.tgz

    echo "Copying /usr/local .."
    ssh $1 'cd /usr; tar czf - local ' | cat - > usr-local.tgz

    echo "Taking command views (crontab, ps, ip, netstat, df) .."
    ssh $1 'crontab -l' > crontab-l
    ssh $1 'ps auxf' > ps-auxf
    ssh $1 'ip a s' > ip-as
    ssh $1 'netstat -pln' > netstat-plnt
    ssh $1 'df -h' > df-h

    echo "done"
    cd -
}
