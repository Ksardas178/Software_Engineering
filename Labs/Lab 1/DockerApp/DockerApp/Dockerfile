#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM mcr.microsoft.com/dotnet/core/runtime:2.1-nanoserver-1809 AS base
WORKDIR /app


FROM mcr.microsoft.com/dotnet/core/sdk:2.1-nanoserver-1809 AS build
WORKDIR /src
COPY ["DockerApp/DockerApp.csproj", "DockerApp/"]
RUN dotnet restore "DockerApp/DockerApp.csproj"
COPY . .
WORKDIR "/src/DockerApp"
RUN dotnet build "DockerApp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "DockerApp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DockerApp.dll"]