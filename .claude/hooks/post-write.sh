#!/bin/bash
# Post-Write/Edit Hook — Test Reminder
# Fires after every write to prevent untested code accumulating

echo "POST-WRITE: Test what you just wrote. One feature, one test. If it fails — revert, do not patch on top of patches."
