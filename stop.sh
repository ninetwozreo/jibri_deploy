#!/bin/bash
show_usage="args: [-t , -r,-b]\
                                  [--timess=, --repository-url=]"
checkInt(){
expr $2+ 0&>/dev/null
[ $? -ne 0] && { echo "Args must be integer!";exit 1; }
}
#参数
#结束 启动服务个数
the_times=""
#开始
the_begin_times="1"
# git仓库url
opt_url=""

# 备份目录
opt_backupdir=""



# web目录
opt_webdir=""

GETOPT_ARGS=`getopt -o r:t:b:w: -al repository-url:,timess:,btimess: -- "$@"`

eval set -- "$GETOPT_ARGS"
#获取参数
while [ -n "$1" ]
do
        case "$1" in
                -t|--timess) the_times=$2; shift 2;;
		-b|--btimess) the_begin_times=$2; shift 2;;
                -r|--repository-url) opt_url=$2; shift 2;;
   	          --) break ;;
                *) echo $1,$2,$show_usage; break ;;
        esac
done

#checkInt $opt_url
if test	-z "$--times"
then
 echo "请输入执行脚本数目"
else
 
 echo "当前执行脚本开始服务为服务$the_begin_times"
 echo "当前执行脚本最终服务为服务$the_times"
 echo "当前启动服务数目为$(($the_times-$the_begin_times+1))"
fi
systemctl daemon-reload
for i in ` seq $the_begin_times $the_times`
#for i-1 in $(seq 0 $the_times+1 ) 
do
#	su - jibri -c "nohup sh /opt/jitsi/jibri/test/launch$i.sh &"
	systemctl stop jibri$i
	

    	echo '正在执行第'+$i+'个服务' 
done
echo "-----------------------------"

