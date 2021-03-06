#!/bin/bash

programname=$0

function usage {
    echo "usage: $programname [number_of_days]"
    echo "  number_of_days can be 3, 7, 30"
    exit 1
}

[ -h $1 ] && { usage; }

num=${1:-3}

# Houses with individually adjustable heating - South
ads_south="http://www.spitogatos.gr/search/results/residential/rent/r102/m102m/uploaded_${num}days/price_nd-700/livingArea_70-110/rooms_2-nd/floorNumber_2-nd/heatingController_autonomous?ref=refinedSearchSR"

wget $ads_south -O searchResults
grep searchListingHover searchResults | awk '{print $9}' > searchResults2
sed -i -e 's/title=//g' searchResults2
sed -i -e 's/"//g' searchResults2
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $(cat searchResults2)
rm -rf searchResults*