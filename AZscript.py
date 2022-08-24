from az.cli import az
import sys

def change_sub(subscriptionId):
    exit_code, result_dict, logs = az("account subscription list")
    if exit_code == 0:
        json_response = (result_dict[0])
    else:
        print("Sorry, something went wrong!")
        print(f"Logs: {logs}")
        print(f"Exit code: {exit_code}")
        sys.exit()

    if subscriptionId not in json_response['id']:
        tenID = input("Please specify the tenant ID\n")
        az(f'login --tenant {tenID}')
    else:
        az(f"account set --subscription {subscriptionId}")


change_sub(sys.argv[1])
