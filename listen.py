import SimpleHTTPServer
import SocketServer
import logging
import cgi
from subprocess import call
from random import randint

PORT = 9090

QUOTES = []
with open('quotes.txt', 'r') as f:
    for q in f:
        QUOTES.append(q)
MAX = len(QUOTES) -1

class ServerHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def _deploy(self):
        call(['./deploy.sh'])

    def do_response(self):
        self.send_response(200)
        self.send_header('Content-type','text')
        self.end_headers()
        self.wfile.write(QUOTES[randint(0, MAX)])
        return

    def do_GET(self):
        logging.error(self.headers)
        self._deploy()
        self.do_response()

    def do_POST(self):
        logging.error(self.headers)
        self._deploy()
        self.do_response()

if __name__ == '__main__':
    try:
        httpd = SocketServer.TCPServer(("", PORT), ServerHandler)
        print "serving at port", PORT
        httpd.serve_forever()
    except KeyboardInterrupt:
        print "Caught ^C shutting down"
        httpd.socket.close()
    except Exception as e:
        print e
        httpd.socket.close()
