FROM mcr.microsoft.com/dotnet/runtime:2.1
COPY bin/Release/netcoreapp2.1/publish/ DockerApp/
WORKDIR /DockerApp
ENTRYPOINT ["dotnet", "DockerApp.dll"]