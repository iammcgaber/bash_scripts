  #!/bin/bash

  days=${1:-1}
  day_to_search=1
  slack_api_token="<put_api_token_here>"

  if [[ -z ${slack_api_token} ]]; then
      echo "Please enter your slack api token in the script to make api calls."
      exit 1
  fi

  days=$(expr ${days} \* 86400)
  day_to_search=$(expr $(date +%s) - ${days})

 curl -H "Authorization: Bearer ${slack_api_token}" -X POST https://slack.com/api/channels.list | jq '.channels[]' > slack_channels.json

 jq ". | select(.created > ${day_to_search})" slack_channels.json
