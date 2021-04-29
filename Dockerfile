FROM node:8

# Create app directory
WORKDIR /usr/src/app

RUN apt-get -y update

RUN apt-get install -y supervisor

ADD /supervisor /usr/src/app

ADD /core/ /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install

RUN apt-get update || : && apt-get install python -y

RUN apt-get install python3-pip -y

RUN pip3 install zerorpc

RUN npm install zerorpc
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 8000
# EXPOSE 8070

CMD ["supervisord","-c","/usr/src/app/service_script.conf"]
# CMD [ "npm", "start" ]
