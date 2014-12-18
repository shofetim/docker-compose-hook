import SimpleHTTPServer
import SocketServer
import logging
import cgi
from subprocess import call

PORT = 9090

class ServerHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def _deploy(self):
        call(['deploy.sh'])

    def do_GET(self):
        logging.error(self.headers)
        self._deploy()
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        logging.error(self.headers)
        self._deploy()
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)

if __name__ == '__main__':
    try:
        Handler = ServerHandler
        httpd = SocketServer.TCPServer(("", PORT), Handler)
        print "serving at port", PORT
        httpd.serve_forever()
    except KeyboardInterrupt:
        print "Caught ^C shutting down"
        httpd.socket.close()
    except Exception as e:
        print e
        httpd.socket.close()
