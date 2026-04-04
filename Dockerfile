FROM python:3.9-slim-bullseye

RUN apt update && apt install -y nmap

# Create default user folder
RUN mkdir -p /home/pi

# Install dvl service
COPY dvl-a50 /home/pi/dvl-a50
RUN cd /home/pi/dvl-a50 && pip3 install .

LABEL version="1.0.7"
LABEL permissions='\
{\
 "ExposedPorts": {\
   "9001/tcp": {}\
  },\
  "HostConfig": {\
    "Binds":["/root/.config:/root/.config"],\
    "ExtraHosts": [\
      "host.docker.internal:host-gateway"\
    ],\
    "PortBindings": {\
      "9001/tcp": [\
        {\
          "HostPort": ""\
        }\
      ]\
    }\
  }\
}'
LABEL authors='[\
    {\
        "name": "Willian Galvani",\
        "email": "willian@coratiatech.com"\
    }\
]'
LABEL company='{\
        "about": "",\
        "name": "Coratia Technologies",\
        "email": "support@coratiatech.com"\
    }'
LABEL type="device-integration"
LABEL tags='[\
        "positioning",\
        "navigation",\
        "doppler-velocity-log"\
    ]'
LABEL readme='https://raw.githubusercontent.com/coratia/CoratiaOS-Water-Linked-DVL/{tag}/README.md'
LABEL links='{\
        "website": "https://github.com/coratia/CoratiaOS-Water-Linked-DVL",\
        "support": "https://github.com/coratia/CoratiaOS-Water-Linked-DVL/issues"\
    }'
LABEL requirements="core >= 1.1"

ENTRYPOINT /home/pi/dvl-a50/main.py
