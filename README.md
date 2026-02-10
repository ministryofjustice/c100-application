# Family Justice C100 Service

This is a Rails application to enable citizens to complete the C100 form. It will also produce a C1A form and a C8 form under certain circumstances based on the answers the applicant gives (for example if there are safety concerns).

## Getting Started

* Run `brew install shared-mime-info` so MimeMagic works fine if you are on a Mac.

* Copy `.env.example` to `.env` and replace with suitable values. e.g. `cp .env.example .env`
You don't need to configure Notify or Auth0 at this point.

* `yarn install` # will pull [GOV.UK Frontend](https://design-system.service.gov.uk)
* `bundle install`
* `bundle exec rails db:setup`
* `bundle exec rails db:migrate`
* `bundle exec rails server`

## Update existing frontend libraries
```
yarn upgrade --latest
```

## CSS + JS updates
We are now using propshaft, cssbundling-rails and jsbundling-rails. You will need to run
```
yarn build:css --watch
yarn build --watch
```
to build your assets you localhost for the first time. Then everytime you are toding any changes to JS or CSS.

### PDF generating
Grover and Puppeteer handle this, so we are not relying on the deprecated wkthmltopdf library.
Ensure the Puppeteer is installed via js packaging manager and not via image in docker to avoid version discrepancies between chromium and Puppeteer.

### For running the tests:

* Copy `.env.test.example` to `.env.test` e.g. `cp .env.test.example .env.test`
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

ChromeDriver is needed for the integration tests. It can be installed on Mac using Homebrew: `brew cask install chromedriver`

The features can be run manually (these are not part of the default rake task) in any of these forms:

* `bundle exec cucumber features`
* `bundle exec cucumber features/miam.feature`
* `bundle exec cucumber features/miam.feature -t @happy_path`
* `bundle exec cucumber features/miam.feature -t @unhappy_path`

By default cucumber will start a local server on a random port, run features against that server, and kill the server once the features have finished.

If you want to show the browser (useful to debug issues) prefix the commands like this:

* `SHOW_BROWSER=1 bundle exec cucumber features`

Note: if some assets are not found when running cucumber, try deleting the content of the `/tmp` directory (inside your local checkout of the project).

## Setting up ClamAV locally

Set ENV["SKIP_VIRUS_CHECK"] = true

or follow this guide here: https://www.driftingruby.com/episodes/antivirus-uploads-with-clamby

Then run `freshclam && clamd`

## Mutation testing

This project uses extensive mutation coverage, which makes the (mutation) tests take a long time to run, and can end up with the CI killing the build due to excessive job work time.

In order to make this a bit faster, by default in CI master branch and in local when run without any flags, the scope of mutant testing will be reduced to a few models, and a randomized small sample of classes in each of these groups: Form objects and Decision trees.

In PRs, the mutation will be `--since master` meaning only files changed will be tested with mutant. This is much faster than running a random sample and also should be more accurate and pick the classes that matter (the changed ones, if any).

However it is still possible to have full flexibility of what mutant runs in your local environment:

##### Run mutation on a specific file:
`RAILS_ENV=test bundle exec rake mutant C100App::RespondentDecisionTree`

##### Run mutation on the whole project (no random samples):
`RAILS_ENV=test bundle exec rake mutant all`

##### Run mutation on the whole project but only on files changed since master:
`RAILS_ENV=test bundle exec rake mutant master`

##### Run mutation on a small sample of classes (default):
`RAILS_ENV=test bundle exec rake mutant`

## Sidekiq for background job processing

The service makes use of [Sidekiq](https://github.com/mperham/sidekiq) to process background jobs including sending
emails asynchronously. It also requires Redis to be setup and running.

In local machines, to simplify development and minimise dependencies, you can set an ENV variable `QUEUE_ADAPTER=async`
so the jobs are processed in memory.

If you want to replicate a production environment as much as possible, you can use `docker-compose` or you can install
the dependencies locally (Redis and Sidekiq) and then start the redis server (`redis-server`) and sidekiq worker (there
is a [sidekiq.sh](/sidekiq.sh) script to simplify this and other tasks).
Do not forget to unset the `QUEUE_ADAPTER` variable in your local env.

## Back office (Auth0 integration)

There is a back office / admin side that uses [Auth0](http://auth0.com) as the identity provider.
Each application environment (localhost, staging and production) has a corresponding `tenant` in an Auth0 account.

This allow us to have separate configurations for each environment and to test the integration with confidence.

The different tenants contain each an `application` (the C100 backoffice). And each tenant also has `rules` that need to
be present in order to ensure we only allow users who have been previously granted access.

You can test and use the backoffice locally without need for Auth0 credentials. Just expose the `AUTH0_BYPASS_LOCALHOST`
env variable.

Please refer to the [config/auth0](config/auth0) directory for more details.

## Continuous Integration

CircleCI is used for CI and CD and you can find the configuration in `.circleci/config.yml`

After a successful merge to master, a docker image will be created and pushed to an ECR repository.
It will also trigger an automatic deploy to [staging][k8s-staging].

The build will then hold for approval to promote to production environment, at which point it will tag it and push it to the ECR repository, and trigger a rolling update, creating new pods with the new image, and scaling down old pods, as new ones become available.

For more details on the ENV variables needed for CircleCI, refer to the [deploy repo][deploy-repo]. test

[taxtribs]: https://github.com/ministryofjustice/tax-tribunals-datacapture
[deploy-repo]: https://github.com/ministryofjustice/c100-application-deploy
[k8s-staging]: https://c100-application-staging.apps.live-1.cloud-platform.service.justice.gov.uk
[k8s-dev]: https://c100-application-dev.apps.live.cloud-platform.service.justice.gov.uk/

## Deployment to DEV/DEMO environment
The image needs to be build and pushed first. This is done in Circle CI.
There is a section deploy_image_to_dev and build_and_push_dev_image in .circleci/config.yml.
When you are in your branch, update the filter rules with your branch name i.e.
from
```
filters:
  branches:
    only:
      - /^development$/
```
to
```
filters:
  branches:
    only:
      - /^rst-5889$/
```
And push the changes. Wait until the build is green in Circle CI.
Then open dev/k8s/deployment.yml from https://github.com/ministryofjustice/c100-application-deploy repository.
Update the value of Trigger env i.e.:
from
```
- name: TRIGGER
  value: "7"
```
to
```
- name: TRIGGER
  value: "8"
```

save it. You don't have to commit.
Then in the same repository (c100-application-deploy)
run following command:
```
kubectl apply --filename dev/k8s/ --namespace c100-application-dev
```
This should pick the latest image build by CI.
Run
```
kubectl get pods -n c100-application-dev
```
to check all pods are ready then you should be able to see your changes in dev URL:

https://c100-application-dev.apps.live.cloud-platform.service.justice.gov.uk/

There is a name and a password, ask other devs for more info.

Deploy trigger: 9
