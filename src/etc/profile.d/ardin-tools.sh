##
## Aliases
##

alias s="ssh"
alias h="host"
alias pwgen-8="pwgen -s -1 8"
alias pwgen-12="pwgen -s -1 12"
alias pwgen-16="pwgen -s -1 16"


##
## Functions
##

function ssl-san()
{
        [[ -z $1 ]] && echo " * Syntax: $FUNCNAME site:port" && return 1
	printf "\n" | openssl s_client -servername $(echo $1 | cut -f 1 -d ':') -connect $1 2>&1 | openssl x509 -text -noout | grep DNS | sed -e 's/^[ \t]*//'
}

function ssl-dates()
{
        [[ -z $1 ]] && echo " * Syntax: $FUNCNAME site:port" && return 1
        sn=$(echo $1 | cut -f 1 -d ':')
        printf "\n" | openssl s_client -servername ${sn} -connect $1 2>&1 | openssl x509 -text -noout | grep DNS | sed -e 's/^[ \t]*//'
        printf "\n" | openssl s_client -servername ${sn} -connect $1 2>&1 | openssl x509 -dates -noout
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

function docker-enter()
{
    CONTAINERS=`sudo docker ps -a | grep Up | awk '{ print $1" "$NF }' | xargs`;
    echo $CONTAINERS;
    ID=`dialog --title " VM Configuration " --stdout --menu "Select container" 22 70 16 $CONTAINERS`;
    sudo docker exec -t -i $ID /bin/bash
}

function docker-clean()
{
	docker rm -v `docker ps -a -q -f status=exited` 2>/dev/null
	docker rmi `docker images -f "dangling=true" -q` 2>/dev/null
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

function decrypt-p12()
{
    [[ -z $1 ]] && echo " * Syntax: $FUNCNAME filename.p12" && return 1
    [[ ! -f $1 ]] && echo "Error: no such file or directory" && return 1
    echo -n "Enter password: "
    read pass

    # create private
    openssl pkcs12 -passin "pass:${pass}" -in "${1}" -clcerts -nocerts -nodes | sed -ne '/-BEGIN PRIVATE KEY-/,/-END PRIVATE KEY-/p' > "${1}.key"

    # certificate
    openssl pkcs12 -passin "pass:${pass}" -in "${1}" -clcerts -nokeys | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > "${1}.crt"

    # chain
    openssl pkcs12 -passin "pass:${pass}" -in "${1}" -clcerts -nokeys -chain | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > "${1}.chain"

    # pem
    cat "${1}.key" > "${1}.pem"                                                                                                                                                       
    cat "${1}.crt" >> "${1}.pem"
    cat "${1}.chain" >> "${1}.pem"

}

