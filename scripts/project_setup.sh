#!/bin/bash

# set perms chmod u+x ./scripts/project_setup.sh
# end immediately on non-zero exit codes
set -e

# print message function
printMsg() {
  echo ""
  date +"%T $*"
}

### commandline options to:
# 1) -e <email address> This is optional, the default value is "none" if no value provided.
# sets the email address on the users generated
# 2) -d <scratch org duration> This is optional and used to customize scratch org duration.
# default value in this script is 7 days

EMAIL=none
SCRATCHORG_DURATION=7

while [[ $# > 1 ]]
do
    key="$1"

    case $key in
    -e)
        EMAIL="$2"
        shift # past argument
        ;;
    -d)
        SCRATCHORG_DURATION="$2"
        shift # past argument
        ;;
    *)
        # unknown option
        ;;
    esac
shift # past argument or value
done

# create scratch org, set as default
printMsg "Start project setup, create scratch org"
sfdx force:org:create -f config/project-scratch-def.json --setdefaultusername -d $SCRATCHORG_DURATION

# push project code
printMsg "Push code to scratch org"
sfdx force:source:push

# TODO: add data load step once data model is complete

# create users
if [ "${EMAIL}" = "none" ]; 
then
  printMsg "Create manager user"
  sfdx force:user:create -f config/users/app_manager.json
  printMsg "Create audit user"
  sfdx force:user:create -f config/users/auditor.json
else
  printMsg "Will setup users with email address ${EMAIL}"
  printMsg "Create manager user"
  sfdx force:user:create -f config/users/app_manager.json email=$EMAIL

  printMsg "Create audit user"
  sfdx force:user:create -f config/users/auditor.json email=$EMAIL
  # reset password on users created above so you get an email
  sfdx force:apex:execute -f scripts/reset_pwd.apex
fi
