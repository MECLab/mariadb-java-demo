
DB_CONNECTION_STRING="mariadb_user:password@/demo"

create-db-certs:
	# generate self-signed CA
	cd ./db-server/certs && openssl genrsa 2048 > ca-key.pem
	cd ./db-server/certs && openssl req -new -x509 -nodes -days 3600 -key ca-key.pem -out ca-cert.pem

	# generate server certs
	cd ./db-server/certs && openssl req -newkey rsa:2048 -days 3600 -nodes -keyout server-key.pem -out server-req.pem
	cd ./db-server/certs && openssl rsa -in server-key.pem -out server-key.pem
	cd ./db-server/certs && openssl x509 -req -in server-req.pem -days 3600 -CA ca-cert.pem -CAkey ca-key.pem -out server-cert.pem

verify-certs:
	cd ./db-server/certs && openssl verify -CAfile ca-cert.pem server-cert.pem

db-start: db-stop
	docker-compose up mariadb -d

db-stop:
	docker-compose down mariadb

db-up:
	goose -dir db-server/migrations mysql ${DB_CONNECTION_STRING} up

db-nuke:
	goose -dir db-server/migrations mysql ${DB_CONNECTION_STRING} down

install-jdbc-driver:
	cd app/drivers && curl -SOLs https://downloads.mariadb.com/Connectors/java/connector-java-3.2.0/mariadb-java-client-3.2.0.jar

docker-build:
	docker build -t mariadb-demo:latest ./app

demo-run: docker-build
	docker-compose up demo-run && docker-compose down demo-run

run:
	java -cp ./app/drivers/*:./app/target/classes org/example/Main