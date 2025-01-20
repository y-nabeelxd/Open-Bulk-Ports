usage() {
    echo "Usage: $0 -s <start_port> -e <end_port>"
    exit 1
}

while getopts "s:e:" opt; do
    case $opt in
        s) START_PORT=$OPTARG ;;
        e) END_PORT=$OPTARG ;;
        *) usage ;;
    esac
done

if [ -z "$START_PORT" ] || [ -z "$END_PORT" ]; then
    usage
fi

if [ "$START_PORT" -gt "$END_PORT" ]; then
    TEMP=$START_PORT
    START_PORT=$END_PORT
    END_PORT=$TEMP
fi

for PORT in $(seq $START_PORT $END_PORT); do
    sudo ufw allow $PORT
    echo "Port $PORT opened"
done

sudo ufw reload

