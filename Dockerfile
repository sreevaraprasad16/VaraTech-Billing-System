FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY . /usr/local/tomcat/webapps/Billing

EXPOSE 8080
