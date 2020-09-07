import os
master_node = os.getenv("MASTER_NODE")
slave_nodes = os.getenv("SLAVE_NODES").split(',')
repo_endpoint = "/service/rest"
healthcheck_endpoint = "/v1/status"
