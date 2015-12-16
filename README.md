# Hurtworld Server

This project contains a Dockerfile for getting Hurtworld up and running in a Docker container.

## Usage

First, install [docker](https://www.docker.com/).

	$ make
	$ make runserver
	docker run -dP fishworks/hwserver
	b0d7d753caeac465acaf55f790f85e973a1fce17bc19518df6c2538464f96a45

You should then see your container up and running:


	$ docker ps
	CONTAINER ID        IMAGE                COMMAND             CREATED             STATUS              PORTS                                                NAMES
	b0d7d753caea        fishworks/hwserver   "/bin/start"        29 seconds ago      Up 29 seconds       0.0.0.0:32769->12871/tcp, 0.0.0.0:32768->12881/tcp   drunk_poitras

At this point, you can check the server logs:

	$ docker exec b0d7d753caea cat hurtworld.log
	[S_API FAIL] SteamAPI_Init() failed; SteamAPI_IsSteamRunning() failed.
	Setting breakpad minidump AppID = 393420
	rtworld_Data/Mono'
	Mono config path = '/home/hwserver/serverfiles/Hurtworld_Data/Mono/etc'
	PlayerPrefs - Creating folder: /home/hwserver/.config/unity3d/Bankroll Studios
	PlayerPrefs - Creating folder: /home/hwserver/.config/unity3d/Bankroll Studios/Hurtworld
	Forcing GfxDevice: 4
	NullGfxDevice:
	[...]

Or, if you just want to tail the server files:

	$ docker exec -it b0d7d753caea tail -f hurtworld.log

At this point, you can now connect to your own server! Open up Hurtworld, press F1 to open the
console and run

	$ connect localhost

You're in!
