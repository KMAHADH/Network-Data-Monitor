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

intface1=Interface1

intface2=Interface2

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

printf %"$arith"s |tr " " " "

echo -ne "|"
echo ""
echo "+---------------------------------------+"

