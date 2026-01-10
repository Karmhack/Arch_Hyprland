#!/bin/bash

echo "Configuring printing services..."

sudo systemctl enable --now cups.socket

echo "Printing services configured !"