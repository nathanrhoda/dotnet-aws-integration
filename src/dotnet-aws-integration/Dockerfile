#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["dotnet-aws-integration.csproj", "."]
RUN dotnet restore "./dotnet-aws-integration.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "dotnet-aws-integration.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "dotnet-aws-integration.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "dotnet-aws-integration.dll"]