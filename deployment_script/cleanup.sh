#!/usr/bin/env bash

target_dir=/opt/bahmni-web/etc/bahmni_config
if [ -d "$target_dir" ]; then
    rm -rf "$target_dir"
fi
