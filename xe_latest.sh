#!/bin/bash

programname=$0

function usage {
    echo "usage: $programname [number_of_days]"
    echo "  number_of_days can be 1, 3, 10, 30"
    exit 1
}

[ -h $1 ] && { usage; }

num=${1:-3}

# Houses with individually adjustable heating 
# Center
ads_center="http://www.xe.gr/property/search?System.item_type=re_residence&Transaction.type_channel=117541&Geo.area_id_new__hierarchy=82271&Item.has_autonomous_heating=5332&Transaction.price.to=700&Item.area.from=70&Item.area.to=110&Item.bedrooms.from=2&Publication.level_num.from=3&Publication.age=${num}"
# Center - South
ads_center_south="http://www.xe.gr/property/search?System.item_type=re_residence&Transaction.type_channel=117541&Geo.area_id_new__hierarchy=82470,82472,82466,82468,82474,82473&Item.has_autonomous_heating=5332&Transaction.price.to=700&Item.area.from=70&Item.area.to=110&Item.bedrooms.from=2&Publication.level_num.from=3&Publication.age=${num}"

declare -a links=($ads_center $ads_center_south)
links_length=${#links[@]}

for (( i=1; i<${links_length}+1; i++ ));
do
	wget ${links[$i-1]} -O searchResults_$i
	grep "r_t" searchResults_$i | awk '{print $2}' > searchResults$i
	sed -i -e 's/href=/http:\/\/www.xe.gr/g' searchResults$i
	sed -i -e 's/"//g' searchResults$i
	sed -i -e 's/title=//g' searchResults$i
	sed -i -e 's/"//g' searchResults$i
	grep "http" searchResults$i > searchResultss$i
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $(cat searchResultss$i)
	rm -rf searchResults*
done