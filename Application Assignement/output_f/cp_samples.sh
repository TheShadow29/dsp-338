#!/bin/bash

for i in {1..250..5}
do
	filename="frame_"$i".png"
	# echo $filename
	cp ./original/$filename ./original_sampled/$filename
done
	
