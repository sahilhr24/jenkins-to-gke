#Use the official Nginx image
FROM nginx:latest

#Set working directory
#WORKDIR /usr/share/nginx/html

#Copy the HTML files
COPY default.conf /etc/nginx/conf.d/

#Remove the default index.html file
#RUN rm -f /usr/share/nginx/html/index*

COPY index.html /usr/share/nginx/html/
#COPY ondc-site-verification.html /usr/share/nginx/html/

#Expose port 8080 for Cloud Run
EXPOSE 8080

#Override the default Nginx configuration (if needed)
#COPY nginx.conf /etc/nginx/nginx.conf

#Start Nginx
CMD ["nginx", "-g", "daemon off;"]
