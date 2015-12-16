from debian:jessie

ENV HW_USER hwserver
ENV HW_HOME /home/$HW_USER

# add Hurtworld user
RUN adduser --disabled-password --gecos "" --home $HW_HOME $HW_USER

# install dependencies required to get this working
RUN apt-get update && apt-get install -y \
	ca-certificates \
	lib32gcc1 \
	lib32stdc++6 \
	sudo \
	wget \
	--no-install-recommends

# download and unpack SteamCMD
# $STEAMEXE is important to point Hurtworld at the right steam client
ENV STEAMEXE /usr/local/steamcmd
RUN mkdir $STEAMEXE && \
	cd $STEAMEXE && \
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
	tar -xzf steamcmd_linux.tar.gz && \
	rm steamcmd_linux.tar.gz

# install hurtworld
ENV INSTALL_DIR $HW_HOME/serverfiles
RUN /usr/local/steamcmd/steamcmd.sh +force_install_dir $INSTALL_DIR +login anonymous +app_update 405100 validate +quit

# symlink steam client libs
RUN ln -s $INSTALL_DIR/steam_appid.txt $HW_HOME/steam_appid.txt
RUN ln -s $STEAMEXE/linux32/steamclient.so $INSTALL_DIR/Hurtworld_Data/Plugins/x86/steamclient.so
RUN ln -s $INSTALL_DIR/linux64/steamclient.so $INSTALL_DIR/Hurtworld_Data/Plugins/x86_64/steamclient.so

# ensure $HW_HOME is owned by $HW_USER
RUN chown -R $HW_USER:$HW_USER $HW_HOME

# copy any custom stuff added to the server
COPY rootfs /

EXPOSE 12871
EXPOSE 12881

USER $HW_USER
WORKDIR $HW_HOME

CMD ["/bin/start"]
