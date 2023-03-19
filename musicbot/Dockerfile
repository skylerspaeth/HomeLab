FROM openjdk:11.0.15-slim
ENV JMB_VER=0.3.9

RUN apt update && apt install -y curl

RUN mkdir /app
WORKDIR /app

COPY start.sh .
RUN curl -LO https://github.com/jagrosh/MusicBot/releases/download/$JMB_VER/JMusicBot-$JMB_VER.jar

ARG USERNAME=appuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN addgroup --system --gid $USER_GID $USERNAME
RUN adduser --system --uid $USER_UID --group appuser

# Needed so start script can populate it
RUN touch config.txt
RUN chown $USERNAME config.txt

USER $USERNAME

CMD ./start.sh $JMB_VER
