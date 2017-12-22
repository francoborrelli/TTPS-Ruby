# Trabajo Final Integrador - TTPS Ruby 2017

## Requisitos
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Ruby](https://www.ruby-lang.org/es/)
- [Bundle gem](https://github.com/bundler/bundler)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Instalando el proyecto

Para instalar el proyecto es necesario abrir la terminal y ejecutar los siguientes comandos:

```sh
git clone git@github.com:francoborrelli/TTPS-Ruby.git
cd TTPS-Ruby
docker-compose build
```

## Levantando el proyecto

Para levantar el proyecto es necesario estar posicionado en la carpeta del proyecto y ejecutar los comandos:

```sh
docker-compose up -d
docker-compose exec web rails db:setup
```

Una vez hecho esto, se podrá acceder al sitio desde http://localhost:3000, con el nombre de usuario `admin` y la contraseña `123456`.

## Corriendo los tests
Para correr todos los tests juntos utilizando el comando:
```sh
docker-compose exec web rails test
```
Para correrlos uno por uno:
```sh
docker-compose exec web rails test test/models/course_test.rb
docker-compose exec web rails test test/models/examination_test.rb
docker-compose exec web rails test test/models/student_test.rb
docker-compose exec web rails test test/models/score_test.rb
```

## Terminando
Para finalizar es necesario ejecutar:

```sh
docker-compose down
```
