.PHONY: main nginx mysql bench result

main: bench result

nginx:
	sudo systemctl reload nginx
	: > /var/log/nginx/access.log

mysql:
	sudo systemctl restart mysql
	: > /var/log/mysql/mysql-slow.log

golang:
	cd webapp/go && make
	sudo systemctl restart isubata.golang

bench:
	cd bench && ./bin/bench -remotes=54.95.70.255 -output result.json

result:
	cat /home/isucon/isubata/bench/result.json | jq .score
