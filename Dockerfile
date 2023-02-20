# We will use python:3.10-alpine as the base image for building the Flask container
FROM python:3.10-alpine
# It specifies the working directory where the Docker container will run
WORKDIR /app
# Copying all the application files to the working directory
COPY . .
# Install all the dependencies required to run the Flask application
RUN pip install -r requirements.txt
# Expose the Docker container for the application to run on port 5000 and set up automatic port-forwarding
EXPOSE 5000:5000
# Run the application using gunicorn with 4 workers
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "wsgi:app"]