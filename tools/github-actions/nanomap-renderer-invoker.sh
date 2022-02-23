#!/bin/bash
# Generate maps
map_files=(
    "./maps/yw/cryogaia-02-mining.dmm"
    "./maps/yw/cryogaia-03-transit.dmm"
    "./maps/yw/cryogaia-04-maintenance.dmm"
    "./maps/yw/cryogaia-05-main.dmm"
    "./maps/yw/cryogaia-06-upper.dmm"
    "./maps/offmap_vr/talon/talon_v2.dmm"
)

tools/github-actions/nanomap-renderer minimap -w 2240 -h 2240 "${map_files[@]}"

# Move and rename files so the game understands them
cd "data/nanomaps"

mv "talon_v2_nanomap_z1.png" "cryogaia_nanomap_z13.png"
mv "cryogaia-02-mining_nanomap_z1.png" "cryogaia_nanomap_z2.png"
mv "cryogaia-03-transit_nanomap_z1.png" "cryogaia_nanomap_z3.png"
mv "cryogaia-04-maintenance_nanomap_z1.png" "cryogaia_nanomap_z4.png"
mv "cryogaia-05-main_z1.png" "cryogaia_nanomap_z5.png"
mv "cryogaia-06-upper_nanomap_z1.png" "cryogaia_nanomap_z6.png"

cd "../../"
cp data/nanomaps/* "icons/_nanomaps/"