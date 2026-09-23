#!/bin/bash

stow_update_simple() {
  base_path=$1

  echo "Update stow"
  mkdir -p "$base_path"
  stow -d stow_packages -t "$base_path" "--$STOW_MODE" "$MODULE"
}

stow_update_templated() {
  base_path=$1

  echo "Update stow"
  if [[ "$MODE" == "install" ]]; then
    mkdir -p "stow_packages/$MODULE/configs"
    pushd "stow_packages/$MODULE/templates" >/dev/null || exit 1

    ENV_ARGS=()
    while IFS='=' read -r key val; do
      [[ -n "$key" ]] && ENV_ARGS+=("-D" "$key=$val")
    done < <(env)

    shopt -s dotglob nullglob
    for template in *.j2; do
      jinja2 "${ENV_ARGS[@]}" "$template" >"../configs/${template%.j2}"
    done

    popd >/dev/null || exit 1
  fi

  mkdir -p "$base_path"
  stow -d "stow_packages/$MODULE" -t "$base_path" "--$STOW_MODE" configs
}
