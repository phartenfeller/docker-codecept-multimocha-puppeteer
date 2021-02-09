FROM zenika/alpine-chrome:86-with-puppeteer

USER root

RUN mkdir /tests && \ 
  mkdir /tests/output && \ 
  chown -R chrome:chrome /tests

RUN mkdir /codecept && \ 
  chown -R chrome:chrome /codecept

COPY . /codecept

RUN cd /codecept && yarn --prod

USER chrome

WORKDIR /codecept

# Run tests
CMD ["ash", "/codecept/scripts/run.sh"]
