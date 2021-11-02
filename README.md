# URL Shortener

Simple Rails 6.1 short link application to demonstrate common Rails design patterns, asyncronous background job processing, best UI/UX practises with Tailwindcss, robust local development setup with Docker and reliable CI/CD pipeline with Gitlab.

<table>
  <tr>
    <th>Short Url</th>
  </tr>
  <tr>
    <th>
      <img width="500" alt="Sapp" src="https://i.ibb.co/9s4Nd9x/Screenshot-2021-11-02-at-12-03-52-PM.png">
    </th>
  </tr>
</table>

A demo site can be found here [https://scary-plague-04902.herokuapp.com/](https://scary-plague-04902.herokuapp.com/).

[[_TOC_]]

## Features

-   Time series page view reporting with [TimescaleDB](https://www.timescale.com) postgresql extension.
-   Auto refresh title after crawl completion via [ActionCable](https://github.com/rails/rails/tree/master/actioncable) using the publish/subscribe pattern.
-   Background jobs with [ActiveJob](https://github.com/rails/rails/tree/master/activejob) to handle title crawl and page view tracking.
-   Pagination using the [Pagy](https://ddnexus.github.io/pagy/) gem.
-   Bundle JavaScript libraries with [Yarn](https://yarnpkg.com).
-   Usage of form object, service obejct, presenter object and facade objects for better testing and to reduce the model & controller clutter.
-   Test coverage with rspec [Rspec](https://rspec.info/).
-   Container deployment to Heroku [Heroku](https://devcenter.heroku.com/articles/container-registry-and-runtime). Can further expand to use Kubernetes/Helm Charts.
-   Utility-first CSS with [Tailwindcss](https://tailwindcss.com/docs).
-   IP to geolocation with [Maxmind GeoLite2](https://dev.maxmind.com/geoip/geolite2-free-geolocation-data?lang=en)
-   Unit & Integration tests with Rspec, Factory Bot, VCR and Webmock.

## Local Development

Setting up for the local development is fairly simple. Make sure [Docker](https://www.docker.com/get-docker) and [docker-compose](https://github.com/docker/compose/releases) are installed on your computed before running the script below.

Bring up all containers and prepare migration, bundler install and yarn install:

```shell
./dev/docker-env-refresh.sh
```

After that open [http://localhost:8080](http://localhost:8080)

This script automates destroying and rebuilding all docker containers and the main goal is to help run tests against a fresh environment both on local and on CI.

### Useful docker-compose commands

How to run command inside container:

```shell
 docker-compose run --rm web /bin/sh

 /var/www/coingecko # rails routes
```

Running rspec:

```shell
 docker-compose up rspec
```

Run bundle install with --rm flag to remove the container after running bundler:

```shell
docker-compose run --rm web bundle install
```

Check Rails development logs:

```shell
docker-compose exec web tail -f log/development.log
```

## Tests / CI

<table>
  <tr>
    <th>Gitlab CI/CD Pipeline</th>
  </tr>
  <tr>
    <th>
      <img width="500" alt="pipeline" src="https://i.ibb.co/rHDn1kr/Screenshot-2021-11-02-at-3-05-26-AM.png">
    </th>
  </tr>
</table>

[Gitlab Pipeline](https://gitlab.com/iqbal.hasnan/cg-short-url/-/pipelines) is configured to run the test on every merge request. The merge request can only be merged once the test passed.

After merging to the master branch, another pipeline will trigger the production image built and pushed to Heroku Container Registry. The container image is tagged with the commit SHA to allow rollback in the future. The container is then released to Heroku.

Gitlab CI/CD configurations can be found here [.gitlab-ci.yml](.gitlab-ci.yml)

### Environment & Secret variables

Deployment variables are stored in Gitlab CI/CD ENVARS

<table>
  <tr>
    <th>ENVARS</th>
  </tr>
  <tr>
    <th>
      <img width="500" alt="pipeline" src="https://i.ibb.co/NSNJ9B8/Screenshot-2021-11-02-at-12-39-31-PM.png">
    </th>
  </tr>
</table>

## Production deployment

The Production Dockerfile leverages the multi-stage builds approach to ensure the size of the image is small. Dockerfile for production build is located in [Dockerfile](Dockerfile).

Container is deployed at the very last step of the pipeline after sucessful test and image build stage.

This container approach allows for more advance deployment to Kubernetes cluster using Helm Charts.

## Demo

A demo site can be found here [https://scary-plague-04902.herokuapp.com/](https://scary-plague-04902.herokuapp.com/).
