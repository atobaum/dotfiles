# usage: 1pwtool.sh get ../config/prod/secret.tfvars.example
# usage: 1pwtool.sh get ../config/prod/secret.tfvars
#
GIT_ROOT_PATH=$(git rev-parse --show-toplevel)
FILE_PATH=$(realpath "$2")
REL_FILE_PATH=$(realpath --relative-to="$GIT_ROOT_PATH" "$FILE_PATH")
REPO=$(git remote get-url origin | sed "s/.*\///g" | sed "s/\.git$//")
ITEM_PATH=$(echo "$REPO/$REL_FILE_PATH" | sed "s/\.example//")

echo "$ITEM_PATH"

get_secret(){
  local secret_path=$(echo "$FILE_PATH" | sed "s/\.example//")
  if [[ $(basename "$secret_path") == "secrets.tfvars" ]] || [[ $(basename "$secret_path") == "secretmanager.tfvars" ]]; then
    op item get --vault="그룹_제품_DevOps Engineer" --fields label=notesPlain --format json "$ITEM_PATH" | jq -r ".value" > "$secret_path"
  else
    echo "invalid secret path $secret_path"
  fi
}

update_secret(){
  local example_path=$(echo "$FILE_PATH.example")
  if [[ $(basename "$example_path") == "secrets.tfvars.example" ]] || [[ $(basename "$example_path") == "secretmanager.tfvars.example" ]]; then
    cat "$FILE_PATH" | sed "s/= \".*\"/= \"\"/g" | sed "s/: \".*\"/: \"\"/g" > "$example_path"
    # op item get --vault="그룹_제품_DevOps Engineer" --fields label=notesPlain --format json $ITEM_PATH | jq -r ".value" > $secret_path
  else
    echo "invalid example path $example_path"
  fi
}

main(){
  case $1 in  
    "get")  
      get_secret 
        ;;  
    "update")  
      update_secret
        ;;  
    *)  
        echo "invalid command $1"  
        ;;
  esac
}

main "$1" "$2"
