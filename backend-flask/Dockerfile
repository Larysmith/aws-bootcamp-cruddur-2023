FROM python:3.10-slim-buster


WORKDIR /backend-flask

# outside container -> inside container
# contains the libraries you want to install to run the app
COPY requirements.txt requirements.txt

# inside container
# install the python libraries used for the app
RUN pip3 install -r requirements.txt

# outside container -> inside container
# . means everything in the current directory
# first period . - /backend-flask (outside container)
# second period . - /backend-flask (inside container)
COPY . .

# set environmental variables
# inside container and will remain set when the container is running
ENV FLASK_ENV=development
ENV FLASK_DEBUG=1

EXPOSE ${PORT}

# CMD(command)
# python3 -m flask run --host=0.0.0.0 --port=4567
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567"]
