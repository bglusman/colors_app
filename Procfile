resque: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 bundle exec rake resque:work

scheduler: bundle exec rake resque:work QUEUE=*

worker: bundle exec rake resque:scheduler QUEUE=*
