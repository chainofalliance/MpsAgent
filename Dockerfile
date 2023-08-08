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

COPY --from=builder /build/out/* .
COPY build.zip start.sh MultiplayerSettingsTemplate.json ./
RUN rm MultiplayerSettings.json

EXPOSE 56100

CMD /app/start.sh
