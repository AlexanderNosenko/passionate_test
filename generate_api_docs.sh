#!/bin/bash
rm swagger/public/swagger.json # remove old swagger.json
bundle exec rspec spec/integration/ --format Rswag::Specs::SwaggerFormatter # generate OpenApi 2.0
yarn run convert_swagger_to_openapi # convert OpenApi 2.0 -> 3.0
rm swagger/v2/swagger.json # remove temp swagger file
mv ./swagger/v2/swagger_openapi3.json ./swagger/public/swagger.json # move OpenApi 3.0 swagger file to public
yarn run swagger-spec-validator ./swagger/public/swagger.json # validate OpenApi scheme
yarn envsub --env TIMESTAMP=$(date +%s) swagger/public/index-template.html swagger/public/index.html
yarn run serve swagger/public # run server locally
