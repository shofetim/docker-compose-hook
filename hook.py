import http.server
import socketserver
import cgi
from subprocess import call
from random import randint

PORT = 9090

QUOTES = []
with open('quotes.txt', 'r') as f:
    for q in f:
        QUOTES.append(q)
MAX = len(QUOTES) -1

class ServerHandler(http.server.SimpleHTTPRequestHandler):
    def _deploy(self):
        call(['docker-compose', '-f', '/tmp/docker-compose.yml', 'build'])
        call(['docker-compose', '-f', '/tmp/docker-compose.yml', 'up', '-d'])

    def do_response(self):
        self.send_response(200)
        self.send_header('Content-type','text')
        self.end_headers()
        self.wfile.write(bytes(QUOTES[randint(0, MAX)], 'UTF-8'))
        return

    def do_GET(self):
        self._deploy()
        self.do_response()

    def do_POST(self):
        self._deploy()
        self.do_response()

if __name__ == '__main__':
    try:
        httpd = socketserver.TCPServer(("", PORT), ServerHandler)
        print("serving at port", PORT)
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("Caught ^C shutting down")
        httpd.socket.close()
    except Exception as e:
        print(e)
