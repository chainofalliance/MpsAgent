FROM mcr.microsoft.com/dotnet/sdk:7.0 AS builder
WORKDIR /build

COPY . .
RUN cd LocalMultiplayerAgent && dotnet build --runtime linux-x64 -c Release -o /build/out

FROM mcr.microsoft.com/dotnet/sdk:7.0
WORKDIR /app/
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y gettext zip unzip
RUN mkdir out
RUN mkdir /app/logs

RUN if [[ "$(uname -s)" == "Linux"* ]]; then export IS_LINUX_HOST=true; else export IS_LINUX_HOST=false; fi

COPY --from=builder /build/out/* .
COPY build.zip start.sh MultiplayerSettingsTemplate.json ./
RUN rm MultiplayerSettings.json

EXPOSE 56100
EXPOSE 7777

CMD /app/start.sh
