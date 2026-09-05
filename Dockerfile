FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY Login.jsp /usr/local/tomcat/webapps/ROOT/Login.jsp
COPY index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp
COPY admin.jsp /usr/local/tomcat/webapps/ROOT/admin.jsp
COPY logout.jsp /usr/local/tomcat/webapps/ROOT/logout.jsp

EXPOSE 8080
