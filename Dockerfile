FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar el csproj y restaurar dentro de su carpeta
COPY testingAPI/*.csproj ./ 
RUN dotnet restore

# Copiar todo el contenido del proyecto
COPY testingAPI/. ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "testingAPI.dll"]
