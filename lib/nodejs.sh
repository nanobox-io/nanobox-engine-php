# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# Often nodejs is required to provide an asset compilation process
# There are multiple ways to detect that this is needed and this process
# may grow over time. We just echo true once any of these match
is_nodejs_required() {
  # package.json is the simplest way to detect
  if [[ -f $(nos_code_dir)/package.json ]]; then
    echo "true"
    return
  fi

  # todo:

  # check for gems in the Gemfile that require nodejs

  # check for bower or any other frontend framework

  echo "false"
  return
}

# Determine the nodejs runtime to install. This will first check
# within the Boxfile, then will rely on default_runtime to
# provide a sensible default
nodejs_runtime() {
  echo $(nos_validate \
    "$(nos_payload "config_nodejs_runtime")" \
    "string" "$(nodejs_default_runtime)")
}

# Provide a default nodejs version.
nodejs_default_runtime() {
  packagejs_runtime=$(package_json_runtime)

  if [[ "$packagejs_runtime" = "false" ]]; then
    echo "nodejs-4.2"
  else
    echo $packagejs_runtime
  fi
}

# todo: extract the contents of package.json
#   Will need https://stedolan.github.io/jq/
#   https://github.com/heroku/heroku-buildpack-nodejs/blob/master/lib/json.sh#L17
#   https://github.com/heroku/heroku-buildpack-nodejs/blob/master/bin/compile#L73
package_json_runtime() {
  echo "false"
}

# Fetch the nodejs runtime and dependencies
nodejs_dependencies() {
  echo "$(nodejs_runtime) python27"
}

# Fetch the list of build-only dependencies
nodejs_build_dependencies() {
  echo "python27"
}

# set the runtime in a file inside of node_modules so that if the
# runtime changes between deploys, we can blast the node_modules
# cache and build fresh.
nodejs_persist_runtime() {
  if [[ -d $(nos_code_dir)/node_modules ]]; then
    echo "$(nodejs_runtime)" > $(nos_code_dir)/node_modules/runtime
  fi
}

# check the runtime that was set at the last deploy, and ensure it
# hasn't changed. If it has changed, we'll return false.
nodejs_check_runtime() {
  if [[ ! -d $(nos_code_dir)/node_modules ]]; then
    echo "true"
    return
  fi

  if [[ "$(cat $(nos_code_dir)/node_modules/runtime)" =~ ^$(nodejs_runtime)$ ]]; then
    echo "false"
  else
    echo "true"
  fi
}

# If the package.json has changed since the previous deploy it should
# be rebuilt to ensure unused packages are purged.
npm_rebuild() {
  if [[ "$(nodejs_check_runtime)" = "false" ]]; then
    cd $(nos_code_dir)
    nos_run_process "Rebuilding npm modules" "npm rebuild"
    cd - > /dev/null
  fi
}

# Installing dependencies from the package.json is done with npm install.
npm_install() {
  if [[ -f $(nos_code_dir)/package.json ]]; then

    cd $(nos_code_dir)
    nos_run_process "Installing npm modules" "npm install"
    cd - > /dev/null
  fi
}

# Prune node modules that are no longer needed
npm_prune() {
  if [[ -f $(nos_code_dir)/package.json ]]; then

    cd $(nos_code_dir)
    nos_run_process "Pruning npm modules" "npm prune"
    cd - > /dev/null
  fi
}

# Generate the payload to render the npm profile template
npm_profile_payload() {
  cat <<-END
{
  "code_dir": "$(nos_code_dir)"
}
END
}

# ensure node_modules/.bin is persisted to the PATH
persist_npm_bin_to_path() {
  nos_template \
    "profile.d/npm.sh" \
    "$(nos_etc_dir)/profile.d/npm.sh" \
    "$(npm_profile_payload)"
}
