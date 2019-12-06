#/bin/bash

      ################################################################################
     ##								                   ##
    ##  A BASH shell script to get your networked sent and received data in GB's  ##
   ##                                                                            ##
  ##  Created by Khwaja Mahad Haq (KMAHADH)                                     ##
 ##                                                                            ##
################################################################################


    ##############################################
   ##  Replace the following with your own 2,  ## 
  ##  Preferred Network Interfaces,           ## 
 ##  In that order respectively!             ##
##############################################

intface1=wlx503eaa447d9c

intface2=wlx74da3858b8de

if [ "$1" == "install" ]; then
    ##Install in home folder!
    echo ""
    echo "Backing up your current Custom Aliases File..."
    sleep 0.3
    echo ""
    cp ~/.bash_aliases ~/.bash_aliases_backup
    echo 'File backed up as ".bash_aliases_backup"'
    sleep 0.3
    echo ""
    echo "Copying the script to your home folder..."
    sleep 0.3
    echo ""
    SCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    cp `echo $SCDIR`/DataMon.sh ~/
    sleep 0.3
    echo ""
    echo "Setting up the script as an alias..."
    sleep 0.3
    echo ""
    echo "alias data-usage='bash /home/`whoami`/DataMon.sh'" >> ~/.bash_aliases
    sleep 0.3
    echo ""
    echo "Script Installed successfully!, You should now see a command as "data-usage" in your terminal, and do not need to explicitly locate and acll this script from now on!"
    sleep 0.3
    echo ""
    echo "You might need to restart your computer or use the following command to refresh your current session:"
    echo ""
    echo ""source ~/.bash_aliases""
    sleep 0.3
    echo ""
    echo "Bye!"
    exit
else
    ##No Install!
    echo ""
fi


  ###################
 ## Default check ##
###################

if [ "$intface1" == "Interface1" ]; then
    ##Check Failed!
    echo ""
    echo "You need to configure the script with your own network interfaces, first!"
    echo "Refer to the script in your favourite text editor for this!"
    exit
else
    ##Check Passed!
    echo ::
fi

  ################
 ## "ip" check ##
################

checkip=`command -v ip`

if [ -z "$checkip" ]
then
#Check Failed!

      det1='\e[91m"ip" doesnot exist on the system!\e[39m'
      detall1='Please install "ip" on the system'
      echo $det1
      echo $detall1
      exit
else
#Check Passed!

echo -ne ""
fi

  #######################
 ## For Data Received ##
#######################
echo ""
echo "+---------------------------------------+"

list=`ip link | awk -F: '$0 !~ "^[^0-9]"{print $2;getline}'`
if [[ $list == *"$intface1"* ]]; then
devint=`echo $intface1`
rec=`cat /proc/net/dev |  grep -n $devint | awk '{ print $2}'` && recGB=`echo 2k $rec 1000000000 /p | dc` && if [[ $recGB == .* ]]; then echo -ne "| Received: 0$recGB" GB" " ; else echo -ne "| Received: $recGB" GB" "; fi

elif [[ $list == *"$intface2"* ]]; then

devint=`echo $intface2`
rec=`cat /proc/net/dev |  grep -n $devint | awk '{ print $2}'` && recGB=`echo 2k $rec 1000000000 /p | dc` && if [[ $recGB == .* ]]; then echo -ne "| Received: 0$recGB" GB" " ; else echo -ne "| Received: $recGB" GB" "; fi

##Fallback for default, Internal Wi-Fi.
elif [[ $list == *"wlo1"* ]]; then

devint=wlo1
rec=`cat /proc/net/dev |  grep -n $devint | awk '{ print $2}'` && recGB=`echo 2k $rec 1000000000 /p | dc` && if [[ $recGB == .* ]]; then echo -ne "| Received: 0$recGB" GB" " ; else echo -ne "| Received: $recGB" GB" "; fi

else

devint="eno1" ##Default internal Ethernet for most devices!

rec=`cat /proc/net/dev |  grep -n $devint | awk '{ print $3}'` && recGB=`echo 2k $rec 1000000000 /p | dc` && if [[ $recGB == .* ]]; then echo -ne "| Received: 0$recGB" GB" " ; else echo -ne "| Received: $recGB" GB" "; fi
fi


  ###################
 ## For Data Sent ##
###################

list=`ip link | awk -F: '$0 !~ "^[^0-9]"{print $2;getline}'`

if [[ $list == *"$intface1"* ]]; then

devint=`echo $intface1`
send=`cat /proc/net/dev | grep -n $devint | awk '{ print $10}'` && sendGB=`echo 2k  $send 1000000000 /p | dc` && if [[ $sendGB == .* ]]; then echo -ne "| Sent: 0$sendGB" GB"" ; else echo -e "| Sent: $sendGB" GB""; fi

elif [[ $list == *"$intface2"* ]]; then

devint=`echo $intface2`
send=`cat /proc/net/dev | grep -n $devint | awk '{ print $10}'` && sendGB=`echo 2k  $send 1000000000 /p | dc` && if [[ $sendGB == .* ]]; then echo -ne "| Sent: 0$sendGB" GB"" ; else echo -e "| Sent: $sendGB" GB""; fi

##Fallback for default, Internal Wi-Fi.
elif [[ $list == *"wlo1"* ]]; then

devint=wlo1
send=`cat /proc/net/dev |  grep -n $devint | awk '{ print $2}'` && sendGB=`echo 2k $send 1000000000 /p | dc` && if [[ $sendGB == .* ]]; then echo -ne "| Sent: 0$sendGB" GB"" ; else echo -e "| Sent: $sendGB" GB""; fi

else

devint="eno1" ##Default internal Ethernet for most devices!

send=`cat /proc/net/dev |  grep -n $devint | awk '{ print $3}'` && sendGB=`echo 2k $send 1000000000 /p | dc` && if [[ $sendGB == .* ]]; then echo -ne Sent: " 0$sendGB" GB"" ; else echo -ne "| Sent: $sendGB" GB" "; fi
fi

echo -ne "\033[6n"            # ask the terminal for the position
read -s -d\[ garbage          # discard the first part of the response
read -s -d R foo              # store the position in bash variable 'foo'
horiz="`echo $foo | cut -c 4-5`"      # print the position


let "arith = 41 - $horiz"
EMPTY="$(printf '%*s' $arith)"
echo -ne ""
echo -ne "$EMPTY|"
echo ""
echo -ne "+---------------------------------------+"



DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
