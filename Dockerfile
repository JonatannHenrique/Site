# Build da aplicação
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar csproj da subpasta
COPY Pizzaria/Pizzaria.csproj ./
RUN dotnet restore

# Copiar todo o código
COPY Pizzaria/. ./
RUN dotnet publish -c Release -o out

# Imagem final
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 10000
ENTRYPOINT ["dotnet", "Site.dll"]
