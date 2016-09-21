# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

builtin_document_root() {
  # boxfile builtin_document_root
  document_root=$(nos_validate "$(nos_payload config_builtin_document_root)" "folder" "$(nos_validate "$(nos_payload config_document_root)" "folder" "/")")
  if [[ ${document_root:0:1} = '/' ]]; then
    echo $document_root
  else 
    echo /$document_root
  fi
}

generate_builtin_script() {
  nos_template \
  "bin/run-php-builtin.mustache" \
  "$(nos_data_dir)/bin/run-php" \
  "$(builtin_script_payload)"
  chmod 755 $(nos_data_dir)/bin/run-php
}

builtin_script_payload() {
  cat <<-END
{
  "data_dir": "$(nos_data_dir)",
  "etc_dir": "$(nos_etc_dir)",
  "code_dir": "$(nos_code_dir)",
  "document_root": "$(builtin_document_root)"
}
END
}

configure_builtin() {
	generate_builtin_script
}