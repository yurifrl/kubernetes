FROM redmine

ENV RAILS_ENV production

RUN apt-get update && apt-get install -y build-essential libssh2-1 libssh2-1-dev cmake libgpg-error-dev pkg-config
COPY plugins/ /usr/src/redmine/plugins/
RUN cd /usr/src/redmine/plugins/ && \
    git clone https://github.com/mikoto20000/redmine_git_branch_hook.git && \
    git clone https://bitbucket.org/steveqian/redmine_bitbucket && \
    git clone https://bitbucket.org/productize/bitbucket_reference_redmine.git && \
    git clone https://github.com/speedy32129/time_logger.git && \
    git clone https://github.com/tleish/redmine_remote_revision_url

# git clone https://bitbucket.org/Avalarion/redmine-bitbucket-git.git && \
# git clone https://github.com/jbox-web/redmine_git_hosting.git && $(cd redmine_git_hosting && git checkout 1.2.2 ) && \
# git clone https://github.com/jbox-web/redmine_bootstrap_kit.git && $(cd redmine_bootstrap_kit && git checkout 0.2.5 ) && \
# git clone https://bitbucket.org/steveqian/redmine_bitbucket.git && \
# git clone https://github.com/upgradeya/redmine-contracts-with-time-tracking-plugin.git
COPY config/setup /usr/src/redmine/
COPY config/database.yml config/secrets.yml config/configuration.yml /usr/src/redmine/config/

RUN bundle install --without development test

# RUN mkdir ssh_keys && \
#     ssh-keygen -N '' -f ssh_keys/redmine_gitolite_admin_id_rsa && \
#     chmod 640 ssh_keys/*

