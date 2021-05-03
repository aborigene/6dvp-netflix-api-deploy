# O que é esse repositório?

Aqui ficam os arquivos necessários para executar o docker-compose para o deploy de toda a plataforma de APIs.

## Pré requisitos.

1. Git: https://git-scm.com/book/pt-br/v2/Come%C3%A7ando-Instalando-o-Git
2. Docker: https://docs.docker.com/engine/install/
3. Docker Compose: https://docs.docker.com/compose/install/


## Como usar esse repositório.

1. Clonar o repositório
git clone https://github.com/aborigene/6dvp-netflix-api-deploy.git

2. Entrar na pasta do projeto e executar o docker-compose
docker-compose up -d

## Sobre o projeto:

O Projeto está segmentado em 15 micro serviços, sendo que 3 são de apoio (restore de dados)

1. api-gateway
2. api-gateway-db
3. api-gateway-ui
4. auth
5. auth-db
6. ms-de-apoio-prepare-api-install
7. ms-de-apoio-restore-api-db
8. ms-de-apoio-restore-db    
9. product-details           
10. product-details-db        
11. rabbitmq
12. support 
13. support-db
14. user-details
15. user-details-db

Os micro serviços de apoio deveram ser desligados automáticamente, indicando que o deploy foi finalizado.

6. ms-de-apoio-prepare-api-install
7. ms-de-apoio-restore-api-db
8. ms-de-apoio-restore-db 

## Topologia do projeto:

<img src="https://readme-image.s3.amazonaws.com/6dvp-netflix.jpg" alt="topologia"/>

## APIs

<b>Endpoints - Login</b><br>
/login - Valida usuário e retorna um JWT<br>
<br>
<b>Endpoints - Usuários</b><br>
/setFavorities - Adiciona titulo na lista de favoritos<br>
/setLike - Marcar o filme como gostei<br>
/setDislike - Marca o filme como não gostei<br>
/openTicket - Abre um ticket no suporte<br>
/getUsers - Retorna lista com todos os usuários<br>
/addUser - Adiciona um novo usuário<br>
<br>
<b>Endpoints - Filmes</b><br>
/getMoviesByGenre - Retorna lista de filmes por genero<br>
/getMovie - Retorna um filme específico<br>
/getAllMovies - Retorna lista com todos os filmes<br>
<br>
<b>Endpoint - Suporte</b><br>
/getAllTickets - Retorna lista com todos os chamados<br>
/getTicketsByUser - Retorna lista com todos os chamados por usuário<br>
/getTicketsByStatus - Retorna lista com todos os chamados por status<br>
<br>
<b>Documentação dos endpoint</b> obs.: as APIs de documentação não estão expostas no API Gateway, devem ser acessadas diretamente nos micro-serviços<br>
/swagger-ui-support - Documentação das APIs<br>
/swagger-ui-product-details - Documentação das APIs<br>
/swagger-ui-auth - Documentação das APIs<br>
/swagger-ui-user-details - Documentação das APIs<br>

## Acesso

<b>Portas</b><br>
Kong-API: 8000<br>
Auth: 8090<br>
Support: 8091<br>
Product: 8092<br>
User: 8093<br>
RabbitMQ: 5672<br>
RabbitMQ Management: 15672<br>

<b>Login</b><br>