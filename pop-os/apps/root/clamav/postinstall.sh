#!/usr/bin/env bash

echo "Stopping clamav-freshclam service..."
systemctl stop clamav-freshclam
echo ""

echo "Updating the antivirus database..."
freshclam
echo ""

sleep 2  # wait 2 seconds before starting the service

echo "Starting clamav-freshclam service..."
systemctl start clamav-freshclam
echo ""
