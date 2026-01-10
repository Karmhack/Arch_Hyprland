#!/bin/bash

echo "Configuring nano..."

cat <<'EOF' > "$HOME/.nanorc"
include /usr/share/nano/*.nanorc
set linenumbers
EOF

echo ".nanorc edited !"