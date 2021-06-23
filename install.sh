red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
magenta='\033[1;35m'
cyan='\033[1;36m'
reset='\033[0m'

banner(){
    echo $(clear)
    echo -e "\033[1;32m                      Github:\033[1;0m https://github.com/jockertermux\033[1;35m"
    figlet -c Jocker
    figlet -c Termux
    echo -e "                     _______________________________________\033[1;0m"
    printf "$cyan\n\n"
}

dependencias(){
    command -v ruby > /dev/null 2>&1 || { echo >&2 -e "\e[1;32m[*]\e[1;39m Instalando Ruby-gem..."; pkg install ruby -y;}
    command -v lolcat > /dev/null 2>&1 || { echo >&2 -e "\e[1;32m[*]\e[1;39m Instalando Lolcat..."; gem install lolcat -y;}
    command -v fortune > /dev/null 2>&1 || { echo >&2 -e "\e[1;32m[*]\e[1;39m Instalando Fortune..."; pkg install fortune -y;}
    command -v figlet > /dev/null 2>&1 || { echo >&2 -e "\e[1;32m[*]\e[1;39m Instalando Figlet..."; pkg install figlet -y;}
banner
echo $(clear)
mkdir $PREFIX/libexec/termux/banner
cp -r login_me.sh $PREFIX/libexec/termux/banner/login_me
cp -r main.sh $PREFIX/libexec/termux/banner/main
echo "source $PREFIX/libexec/termux/banner/main"
echo "#         JockerTermux-logerv2.0"
}

main(){
    dependencias
    banner
    until read -n 2 -p "
                              <\CONFIGURE LOGER/>
                        [ 1 ] Enter Your access key
                        [ 2 ] Enter Your Security Question
                        [ 3 ] Enter Your Security Answer
                        [ 4 ] Exit
                        --> " op && [ $op -lt 5 ];do
    printf "\n\n$green Github:$reset https://github.com/jockertermux\n\n"
    sleep 1
    echo $(clear)
    done
    sleep 1
    echo $(clear)
    enter
}

enter(){
case $op in
1)
    banner
    while read -s -p "                     Enter Your Password --> " pas && [ -z $pas ];do
        printf "\n\n$green Github:$reset https://github.com/jockertermux\n\n"
        sleep 1
        echo $(clear)
    done
    echo "$pas" > $PREFIX/libexec/termux/ak
    base64 $PREFIX/libexec/termux/ak > $PREFIX/libexec/termux/.jocker
    rm $PREFIX/libexec/termux/ak
    main
;;
2)
    banner
    while read -s -p "                     Enter Your Security Question --> " ques && [[ -z $ques ]];do
	printf "\n\n$green Github:$reset https://github.com/jockertermux\n\n"
    done
    echo "$ques" > $PREFIX/libexec/termux/quiz
    base64 $PREFIX/libexec/termux/quiz > $PREFIX/libexec/termux/.question
    rm $PREFIX/libexec/termux/quiz
    sleep 1
    echo $(clear)
    main
;;
3)
    banner
    while read -s -p "                     Enter Your Security Answer --> " answ && [[ -z $answ ]];do
	printf "\n\n$green Github:$reset https://github.com/jockertermux\n\n"
    done
    echo "$answ" > $PREFIX/libexec/termux/aw
    base64 $PREFIX/libexec/termux/aw > $PREFIX/libexec/termux/.ans
    rm $PREFIX/libexec/termux/aw
    main
;;
4)
    banner
    echo -e "                       $yellow Good Bye"
    exit
;;
esac
}

main
