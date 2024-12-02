#!/bin/bash
brightnessctl get | awk -v max=$(brightnessctl max) '{printf "%.0f%%", ($1 / max) * 100}'
