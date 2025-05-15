# Etapa de build
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src

# Copiar o projeto e restaurar as dependências
COPY *.csproj ./
RUN dotnet restore

# Copiar todo o código e compilar
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Porta padrão ASP.NET Core
EXPOSE 80

# Substitua "MeuSite.dll" pelo nome correto do seu projeto
ENTRYPOINT ["dotnet", "MeuSite.dll"]

