all:
	docker build -t fishworks/hwserver .

run:
	docker run fishworks/hwserver

shell:
	docker run -it fishworks/hwserver bash

runserver:
	docker run -d -p 12871:12871/udp -p 12881:12881/udp fishworks/hwserver
