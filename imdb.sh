#!/usr/local/bin/bash

# Marty Reider
# CIS 191 Final Project

#result=$(wget -qO- https://www.imdb.com/name/nm0000102/)
#echo "$result"

declare -A actor_cache=( ["test value"]="blah" )
declare -A movie_cache=( ["test value"]="blah" )

rm -r bacon.txt 
touch bacon.txt
movies=()
actors=("nm0000102")
i=0
temp=("${@}")


while (( ${#actors[@]} )); do
	echo "-----------------" >> bacon.txt
	echo "Bacon Number: $i" >> bacon.txt
	echo "-----------------" >> bacon.txt
	i=$((i + 1))
	#echo "${actors[@]}"
	for actor in "${actors[@]}"; do
		actor_cache[$actor]="1"
		movie_step=$(wget -qO- https://www.imdb.com/name/$actor/)
		#movie_step2=$(echo "$movie_step" | grep -Eo "<a href=\"/title/tt[0-9]*" | grep -o "tt.*[0-9]")
		actor_name=$(echo "$movie_step" | grep -o "<span class=\"itemprop\">.*</span>" | grep -o ">.*<" | grep -o "[^>].*[^<]")
		#echo "$actor_name"
		actor_cache[$actor]="$actor_name"
		echo "$actor_name" >> bacon.txt
		movie_step2=$(echo "$movie_step" | grep -E "id=\"actor|\(Short\)|\(TV Movie\)|\(TV Series\)" | grep -Eo "tt.*[0-9]|\(Short\)|\(TV Movie\)|\(TV Series\)" | grep -Eo "tt.*[0-9]|Short|TV Movie|TV Series")

		movies=($(echo $movie_step2 | tr "\n" "\n"))

		j=0
		short_str="Short"
		tv_movie="TV Movie"
		tv_series="TV Series"
		for movie in "${movies[@]}"; do
			#echo "${movies[j + 1]}"
			j=$((j + 1))
			t=$((j))
			if [ "${movies[t]}" != "$short_str" ] && [ "${movies[j]}" != "$short_str" ] && [ "${movies[t]}" != "$tv_movie" ] && [ "${movies[j]}" != "$tv_movie" ]  && [ "${movies[t]}" != "$tv_series" ] && [ "${movies[j]}" != "$tv_series" ]; then
			#if [ "${movies[t]}" != "$short_str" ] && [ "${movies[j]}" != "$short_str" ]; then
				
				#echo "in short movies"
				#echo "${movies[j + 1]}"
				#echo " "


				# select only cast members
				#actor_step=$(wget -qO- https://www.imdb.com/title/$movie/fullcredits | grep -Eo "<a href=\"/name/nm[0-9]*|<h4 class=\"dataHeaderWithBorder.*h4>" | grep -Eo "nm.*[0-9]|<h4 class=\"dataHeaderWithBorder.*h4>" )
				


				actor_step=$(wget -qO- https://www.imdb.com/title/$movie/fullcredits | grep -Eo "<a href=\"/name/nm[0-9]*|<table class=\"cast_list|<\/table>" | grep -Eo "nm.*[0-9]|<table|<\/table>" )
				#echo "$actor_step"
				k=0

				#echo "$actor_step"
				if [ "$actor_step" != "" ]; then
				
					actor_step=($(echo $actor_step | tr "\n" "\n"))
					#echo "$actor_step"
					for a in "${actor_step[@]}"; do

						if [ "$a" == "<table" ]; then
							#echo "k=1"
							k=1

						elif [ "$a" == "</table>" ]; then
							#echo "k=0"
							k=0

						elif ! [[ -v "actor_cache[$a]" ]]; then
							#echo "$a"
							if [ "$k" == "1" ]; then
								#echo "here2"
								actor_cache[$a]="1"
								temp+=($a)
							fi

						fi

					done
				fi
			fi

		done

	done
	if [ "${#temp[@]}" == "0" ]; then
		actors=()
	else
		actors=($(echo "${temp[@]}" | tr "\n" "\n"))
	fi
	#actors=${temp[@]}
	#echo "${#actors[@]}"
	temp=()
	#echo "${#actors[@]}"
	
	#echo "${actors[0]}"
	echo "reached here"
done

echo "the end"



#while [ ${#actors[@]} > 0 ]; do
#	temp=()
#	for actor in "${actors[@]}"; do
#		if ["$actor" in cache]; do
#			result=$(wget -qO- https://www.imdb.com/name/$actor/)
#			echo "$result"
#		done
#	done
#	actors = temp
#
#done

#result2=$(echo "$result" | grep -o "<a href=\"/title.*")
#echo "$result2"
#for i in "$result2"; do
#	echo "$i"
#	echo " "
#done