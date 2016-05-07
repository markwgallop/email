## read config
. /home/pi/code/email/email.cfg

## read params
while [ "$1" != "" ]; do
    case $1 in
        -o | --output )         shift
                                output="$1"
                                ;;
        -s | --subject )        shift
                                subject="$1"
                                ;;
        -m | --message )        shift
                                message="$1"
                                ;;
        -h | --help )           echo "parameters:"
                                echo " -o/--output  [EMAIL] [TEXT]"
                                echo " -s/--subject (...)"
                                echo " -m/--message (...)"
								echo
								echo "eg ./email.sh -m \"test5\" -o \"TEXT EMAIL\" -s subj5"
                                exit
                                ;;
        * )                     exit 1
    esac
    shift
done

echo output: $output
echo subject: $subject
echo message: $message

for format in $output; do echo 
    echo processing $format
	
    case $format in
        "EMAIL" )        recipient="$email_addr"
                         ;;
        "TEXT" )         recipient="$text_addr"
                         ;;
        * )              echo valid outputs are TEXT and or EMAIL
                         exit 1
    esac
    
	echo sending to $recipient
	
    echo "$message" | /usr/sbin/ssmtp -s "$subject" $recipient
done


