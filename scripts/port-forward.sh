#!/bin/bash

SCRIPT=$( basename "$0" )

VERSION="0.0.1"

function usage
{
    local txt=(
    "$SCRIPT is a tool to setup k8s port-forwarding to one or more services in your cluster"
"Usage: $SCRIPT [options]"
""
"Options:"
"  -h     help"
"  -p     set start port (default=4000)"
"  -n     set namespace filter using regex,   format: namespace1|namespace2"
"  -m     set service port map,               format: service1:port1,service2:port2"
""
"Example:"
"$SCRIPT -p 3000                          # set start port to 3000"
"$SCRIPT -n api|service                   # only list services with matching namespaces"
"$SCRIPT -m niffler:3045,munin-api:3022   # use the port map for matching services"
    )

    printf "%s\\n" "${txt[@]}"
}


# init start port default value
port=4000

while getopts 'hp:n:m:' OPTION ; do
  case "$OPTION" in
    p) 
      port=$OPTARG 
    ;;
    n) 
      namespace_filter=$OPTARG
    ;;
    m)
      portmap=$OPTARG
    ;;
    h) 
      usage
      exit 0
    ;;
    *) 
      exit 1
    ;;
  esac
done

if ! command -v fzf &> /dev/null; then
    echo "fzf is not installed. Please install it first."
    exit 1
fi

# List all services and their namespaces
services=$(kubectl get services --all-namespaces -o custom-columns="SERVICE:.metadata.name,NAMESPACE:.metadata.namespace" --no-headers)

if [[ -n "$namespace_filter" ]]; then
    services=$(echo "$services" | grep -E "\s($namespace_filter)\$")
fi

if [ -z "$services" ]; then
    echo "No services found."
    exit 1
fi

# select services
selected_services=$(echo "$services" | fzf --multi --prompt="Select services: ")

if [ -z "$selected_services" ]; then
    echo "No services selected."
    exit 1
fi


pids=()

# Loop through selected services and start port-forwarding
while IFS= read -r selected_service; do
    service=$(echo "$selected_service" | awk '{print $1}')
    namespace=$(echo "$selected_service" | awk '{print $2}')
    use_port=$port

    # use portmap if provided
    if [[ -n $portmap ]]; then
      IFS=',' read -ra pairs <<< "$portmap"
      for pair in "${pairs[@]}"; do
          mapped_service=${pair%%:*}
          mapped_port=${pair##*:}
          
          if [[ $mapped_service == $service ]]; then
              use_port=$mapped_port
              break
          fi
      done
    fi

    # Run kubectl port-forwarding for the selected service
    echo "Port-forwarding svc/$service in namespace $namespace to localhost:$use_port"
    kubectl port-forward --namespace "$namespace" svc/"$service" "$use_port":80 &

    # Store the PID of the background process
    pids+=($!)

    if [[ $port -eq $use_port ]]; then
      # Increment the port for the next service without portmap set
      port=$((port + 1))
    fi

done <<< "$selected_services"

# Wait for user to press 'q' to quit and kill background processes
echo -e "\nPress 'q' to quit and stop all port-forwards.\n"
while true; do
    read -n 1 key
    if [[ $key == "q" ]]; then
        echo -e "\nQuitting..."
        for pid in "${pids[@]}"; do
            kill "$pid"
        done
        break
    fi
done


