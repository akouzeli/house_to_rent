#!/bin/bash

programname=$0

function usage {
    echo "usage: $programname [number_of_days]"
    echo "  number_of_days can be 3, 7, 30"
    exit 1
}

[ -h $1 ] && { usage; }

num=${1:-3}

# Houses with individually adjustable heating
# Center
ads_center="https://www.spitogatos.gr/search/results/residential/rent/r100/m100m/uploaded_${num}days/price_nd-700/livingArea_70-120/rooms_2-nd/floorNumber_1-nd/heatingController_autonomous?ref=refinedSearchSR"
# South
ads_south="https://www.spitogatos.gr/search/results/residential/rent/r102/m102m/uploaded_${num}days/price_nd-700/livingArea_70-110/rooms_2-nd/floorNumber_2-nd/heatingController_autonomous?ref=refinedSearchSR"

declare -a links=($ads_center $ads_south)
links_length=${#links[@]}

for (( i=1; i<${links_length}+1; i++ ));
do
	wget ${links[$i-1]} -O searchResults_$i
	grep searchListingHover searchResults_$i | awk '{print $9}' > searchResults$i
	sed -i -e 's/title=//g' searchResults$i
	sed -i -e 's/"//g' searchResults$i
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $(cat searchResults$i)
	rm -rf searchResults*
done