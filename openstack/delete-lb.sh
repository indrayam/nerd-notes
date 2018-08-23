# Set the lb id
LB_ID="add4f04a-0160-41d0-a1fd-de2461e6997e"

# delete the lb and all sub components.
LB_DATA=$(neutron lbaas-loadbalancer-show ${LB_ID} --format yaml)
LB_LISTENERS_ID=$(echo -e "$LB_DATA" | awk -F'"' '/listeners/ {print $4}')
LB_POOL_ID=$(echo -e "$LB_DATA" | awk -F'"' '/pools/ {print $4}')
LB_HEALTH_ID=$(neutron lbaas-pool-show ${LB_POOL_ID} | awk '/healthmonitor_id/ {print $4}')
neutron lbaas-listener-delete "${LB_LISTENERS_ID}"
neutron lbaas-healthmonitor-delete "${LB_HEALTH_ID}"
neutron lbaas-pool-delete "${LB_POOL_ID}"
neutron lbaas-loadbalancer-delete "${LB_ID}"
