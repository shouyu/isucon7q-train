.PHONY: main nginx mysql bench result

main: nginx mysql bench result

nginx:
	sudo systemctl reload nginx
	: > /var/log/nginx/access.log

mysql:
	sudo systemctl restart mysql
	: > /var/log/mysql/mysql-slow.log

bench:
	cd bench && ./bin/bench -remotes=127.0.0.1 -result result.json

result:
	cat /home/isucon/isubata/bench/result.json | jq .score
