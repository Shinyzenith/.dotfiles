#!/bin/sh
for pad in $(riverctl list-inputs | grep -i touchpad )
do
  riverctl input $pad events enabled
  riverctl input $pad tap enabled
  # riverctl input $pad natural-scroll enabled
done
