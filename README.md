# Family Justice C100 Service

[![CircleCI](https://circleci.com/gh/ministryofjustice/c100-application.svg?style=svg)](https://circleci.com/gh/ministryofjustice/c100-application)

This is a Rails application to enable citizens to complete the C100 form. It will also produce a C1A form and a C8 form 
under certain circumstances based on the answers the applicant gives (for example if there are safety concerns).

It is based on software patterns developed for the [Appeal to the Tax Tribunal][taxtribs] application.

## K8s live-1 cluster

There is a staging environment running on [this url][k8s-staging]

The staging env uses http basic auth to restrict access. The username and
password should be available from the MoJ Rattic server, in the Family Justice group.

This environment should be used for any test or demo purposes, user research, etc.  
Do not use production for tests as this will have an impact on metrics and will trigger real emails

There is a [deploy repo][deploy-repo] for this staging environment, and also for production environment.  
It contains the k8s configuration files and also the required ENV variables.

## Docker

The application can be run inside a docker container. This will take care of the ruby environment, postgres database 
and any other dependency for you, without having to configure anything in your machine.

* `docker-compose up`

The application will be run in "production" mode, so will be as accurate as possible to the real production 
environment (but will not send any emails as the GOV.UK Notify API key is not configured by default).

## Getting Started

* Copy `.env.example` to `.env` and replace with suitable values.  
You don't need to configure Notify or Auth0 at this point.

* `bundle install`
* `bundle exec rails db:setup`
* `bundle exec rails db:migrate`
* `bundle exec rails server`

### For running the tests:

* Copy `.env.test.example` to `.env.test` and replace with suitable values if you expect to run the tests
* `RAILS_ENV=test bundle exec rails db:setup`
* `RAILS_ENV=test bundle exec rails db:migrate`

You can then run all the code linters and tests with:

* `RAILS_ENV=test bundle exec rake`  
or  
* `RAILS_ENV=test bundle exec rake test:all_the_things`

Or you can run specific tests as follows (refer to *lib/tasks/all_tests.rake* for the complete list):

* `RAILS_ENV=test bundle exec rake spec`
* `RAILS_ENV=test bundle exec rake brakeman`

## Cucumber features

The features can be run manually (these are not part of the default rake task) in any of these forms:

* `bundle exec cucumber features`
* `bundle exec cucumber features/screener.feature`
* `bundle exec cucumber features/screener.feature -t @happy_path`
* `bundle exec cucumber features/screener.feature -t @unhappy_path`

By default cucumber will start a local server on a random port, run features against that server, and kill the server once the features have finished.

If you want to point the features at another server (WARNING: NEVER PRODUCTION!), pass the environment variable CUCUMBER_URL (or set the value in your local `.env` file) when calling cucumber:

* `CUCUMBER_URL=http://server.com bundle exec cucumber features`

## Mutation testing

This project uses extensive mutation coverage, which makes the (mutation) tests take a long time to run, and can end up with the CI killing the build due to excessive job work time.

In order to make this a bit faster, by default in CI master branch and in local when run without any flags, the scope of mutant testing will be reduced to a few models, and a randomized small sample of classes in each of these groups: Form objects and Decision trees.

In PRs, the mutation will be `--since master` meaning only files changed will be tested with mutant. This is much faster than running a random sample and also should be more accurate and pick the classes that matter (the changed ones, if any).

However it is still possible to have full flexibility of what mutant runs in your local environment:

##### Run mutation on a specific file:
`RAILS_ENV=test bundle exec rake mutant C100App::OtherPartiesDecisionTree`

##### Run mutation on the whole project (no random samples):
`RAILS_ENV=test bundle exec rake mutant all`

##### Run mutation on the whole project but only on files changed since master:
`RAILS_ENV=test bundle exec rake mutant master`

##### Run mutation on a small sample of classes (default):
`RAILS_ENV=test bundle exec rake mutant`


## CircleCI and continuous deployment

CircleCI is used for CI and CD and you can find the configuration in `.circleci/config.yml`  

After a successful merge to master, a docker image will be created and pushed to an ECR repository.  
It will also trigger an automatic deploy to [staging][k8s-staging].

The build will then hold for approval to promote to production environment, at which point it will tag it 
and push it to the ECR repository, and trigger a rolling update, creating new pods with the new image, and 
scaling down old pods, as new ones become available.

For more details on the ENV variables needed for CircleCI, refer to the [deploy repo][deploy-repo].

[taxtribs]: https://github.com/ministryofjustice/tax-tribunals-datacapture
[deploy-repo]: https://github.com/ministryofjustice/c100-application-deploy
[k8s-staging]: https://c100-application-staging.apps.live-1.cloud-platform.service.justice.gov.uk
