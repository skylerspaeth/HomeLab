FROM openjdk:11.0.15-slim
ENV JMB_VER=0.3.8

RUN apt update && apt install -y curl

RUN mkdir /app
WORKDIR /app

RUN curl -LO https://github.com/jagrosh/MusicBot/releases/download/$JMB_VER/JMusicBot-$JMB_VER.jar

ARG USERNAME=appuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN addgroup --system --gid $USER_GID $USERNAME && adduser --system --uid $USER_UID --group appuser
USER $USERNAME

ENTRYPOINT java -Dnogui=true \
  -Dtoken="$JMB_TOKEN" \
  -Downer="$JMB_OWNER" \
  -Dprefix="$JMB_PREFIX" \
  -Dgame="$JMB_GAME" \
  -jar JMusicBot-$JMB_VER.jar
