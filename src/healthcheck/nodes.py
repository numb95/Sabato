import sys
import config
import requests
slave_status_list = {}
master_status_list = {}
def master_status():
        response = requests.get ("http://" + config.master_node + config.repo_endpoint + config.healthcheck_endpoint)
        master_status_list[config.master_node] = response.status_code
        return master_status_list
def slave_status():
    for slaves in config.slave_nodes:
        response = requests.get ("http://" + slaves + config.repo_endpoint + config.healthcheck_endpoint)
        slave_status_list[slaves] = response.status_code
    return slave_status_list
