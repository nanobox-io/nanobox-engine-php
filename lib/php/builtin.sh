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