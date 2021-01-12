#!/bin/bash
show_usage="args: [-t , -r]\
                                  [--timess=, --repository-url=]"
checkInt(){
expr $2+ 0&>/dev/null
[ $? -ne 0] && { echo "Args must be integer!";exit 1; }
}
#参数
# 启动服务个数
the_times=""


# git仓库url
opt_url=""

# 备份目录
opt_backupdir=""



# web目录
opt_webdir=""

GETOPT_ARGS=`getopt -o r:t:b:w: -al repository-url:,timess: -- "$@"`

eval set -- "$GETOPT_ARGS"
#获取参数
while [ -n "$1" ]
do
        case "$1" in
                -t|--timess) the_times=$2; shift 2;;
                -r|--repository-url) opt_url=$2; shift 2;;
   	          --) break ;;
                *) echo $1,$2,$show_usage; break ;;
        esac
done




rm -rf /opt/jitsi/jibri/test
mkdir /opt/jitsi/jibri/test
for i in `seq $the_times`
#for i-1 in $(seq 0 $the_times+1 ) 
do
	cp /opt/jitsi/jibri/launch.sh /opt/jitsi/jibri/test/launch$i.sh
	cp /opt/jitsi/jibri/reload.sh /opt/jitsi/jibri/test/reload$i.sh
	cp /opt/jitsi/jibri/graceful_shutdown.sh /opt/jitsi/jibri/test/graceful_shutdown$i.sh
	sed -i 's/config.json/config'$i'.json/g' /opt/jitsi/jibri/test/launch$i.sh
	sed -i 's/5000/510'$i'/g' /opt/jitsi/jibri/test/launch$i.sh
	sed -i 's/logging.properties/logging'$i'.properties/g' /opt/jitsi/jibri/test/launch$i.sh
	sed -i 's/3333/343'$i'/g' /opt/jitsi/jibri/test/launch$i.sh
	sed -i 's/2222/232'$i'/g' /opt/jitsi/jibri/test/launch$i.sh
	sed -i 's/3333/343'$i'/g' /opt/jitsi/jibri/test/reload$i.sh
	sed -i 's/3333/343'$i'/g' /opt/jitsi/jibri/test/graceful_shutdown$i.sh
	
	rm -rf /var/log/jitsi/jibri$i
	mkdir /var/log/jitsi/jibri$i
	chmod -R 777 /var/log/jitsi/jibri$i
	chmod -R +x /var/log/jitsi/jibri$i
	rm -rf /etc/jitsi/jibri/logging$i.properties /etc/jitsi/jibri/config$i.json
	cp /etc/jitsi/jibri/logging.properties /etc/jitsi/jibri/logging$i.properties
	cp /etc/jitsi/jibri/config.json /etc/jitsi/jibri/config$i.json
	sed -i 's/jibri-nickname/jibri-nickname'$i'/g' /etc/jitsi/jibri/config$i.json
	sed -i 's/jibri/jibri'$i'/g' /etc/jitsi/jibri/logging$i.properties
	sed -i 's/org.jitsi.jibri'$i'/org.jitsi.jibri/g' /etc/jitsi/jibri/logging$i.properties
	
	cp /etc/systemd/system/jibri.service /etc/systemd/system/jibri$i.service
	sed -i 's#launch#test/launch'$i'#g' /etc/systemd/system/jibri$i.service
	sed -i 's#reload#test/reload'$i'#g' /etc/systemd/system/jibri$i.service
	sed -i 's#graceful_shutdown#test/graceful_shutdown'$i'#g'  /etc/systemd/system/jibri$i.service
    echo '正在执行第'+$i+'次' 
done
echo "-----------------------------"
for key2 in $*
do
    echo '$*' $key2
done
