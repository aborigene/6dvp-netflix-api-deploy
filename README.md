# O que é esse repositório?

Aqui ficam os arquivos necessários para executar o docker-compose para o deploy de toda a plataforma de APIs.

## Pré requisitos.

Docker: https://docs.docker.com/engine/install/
Docker Compose: https://docs.docker.com/compose/install/
Git: https://git-scm.com/book/pt-br/v2/Come%C3%A7ando-Instalando-o-Git

## Como usar esse repositório.

1. Clonar o repositório
git clone https://github.com/aborigene/6dvp-netflix-api-deploy.git

2. Entrar na pasta do projeto e executar o docker-compose
docker-compose up -d

# Sobre o projeto:

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

# Topologia do projeto:

<img src="https://readme-image.s3.amazonaws.com/6dvp-netflix.jpg" alt="topologia"/>
