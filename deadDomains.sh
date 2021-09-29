if [[ $1 == '-h' ]]; then
echo "Step1 -> Export links from burp"
echo "Step2 -> Save them into a file links.txt"
printf "Step3 -> cat links.txt | ./script \n"; 
exit;
fi
echo "" >/tmp/SDomains.txt
grep . > /tmp/domains.txt
cut -d"/" -f3 /tmp/domains.txt | sort -u > /tmp/Odomains.txt
printf "\n\033[31;1m[~] Searching targets : \n\033[0m\n"
echo "Found: $(cat /tmp/Odomains.txt | wc -l) targets"
printf "\n\033[31;1m[~] Searching Dead Subdomains \n\033[0m\n"
while read line; 
do
[[ "$(dig $line +short)" ]] || printf "$line\n" >> /tmp/SDomains.txt
[[ "$(dig $line +short)" ]] ||printf "$line : \033[32;1m Dead \n\033[0m"; 
done</tmp/Odomains.txt
cat /tmp/SDomains.txt | grep '\.' | sed 's/\.$//g' | cut -d"." -f2-100 > /tmp/Domains.txt
printf "\n\033[31;1m[~] Searching Dead Domains \n\033[0m\n"
while read line; 
do
[[ "$(dig $line +short)" ]] || printf "$line : \033[32;1m Dead \n\033[0m"; 
done</tmp/Domains.txt
