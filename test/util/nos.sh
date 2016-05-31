# A nos utility that will override nos functionality to assist with testing

# Global entry of payload vars that have been eval'ed.
# This entry will be used to purge previous variables.
payload_vars=()

# nos_init(1)
#
# $1 = payload
#
# Override nos_init to work within this test structure
nos_init() {

  # initialize globals
  engine_root="/engine/"
  engine_bin_script_dir="/engine/bin"
  engine_template_dir="/engine/templates"
  engine_file_dir="/engine/files"
  engine_lib_dir="/engine/lib"

  if [[ $# -eq 1 ]]; then
    # initialize payload
    nos_eval_payload "$1"
  fi
}

# nos_eval_payload(1)
#
# Overrides the default nos_eval_payload that will allow multiple runs
# and unsets previous values
#
# Extracts the JSON payload into SHON format and evals the result as
# local variables prefixed with PL_
nos_eval_payload() {
  # reset the payload
  nos_reset_payload

  # extract and set new variables
  for var in $(echo "$1" | shon | sed -e "s/^/PL_/"); do
    # extract the key from the variable
    key=$(echo $var | awk -F "=" '{ print $1 }')
    # add the key to the list of payload_vars
    payload_vars+=("$key")
    # eval the variable so that it is available
    eval $var
  done
}

# nos_reset_payload(0)
#
# Resets the payload environment previously set.
nos_reset_payload() {
  # unset payload vars from previous run
  for var in ${payload_vars[@]}; do
    unset $var
  done

  # reset the payload keys
  payload_vars=()
}
