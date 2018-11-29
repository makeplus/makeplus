from ubuntu:18.04

run apt update \
 && apt install -y \
        python \
 && true

entrypoint ["python", "-m", "SimpleHTTPServer", "8000"]
