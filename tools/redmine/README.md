
bundle install --without development test
bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=redmine_git_hosting
bundle exec rake redmine:plugins NAME=redmine_agile RAILS_ENV=production
bundle exec rake redmine:plugins:migrate

#
docker exec -t -i build_web_1 /bin/bash



# Cotent
https://hub.docker.com/_/redmine/
https://github.com/docker-library/docs/tree/master/redmine
https://github.com/74th/docker-redmine-all-in-one
https://github.com/ysuzukisra/gxro/blob/bcd18b6540cfe26e0150ceea2a0fa0df64a83fcf/docker-compose.yml
