//This file is Dark Client. It set up and define a Client, and we will give the hostname and port number in ClientPage.dart.
import 'dart:io';
import 'dart:typed_data';
import 'models.dart';

//Client structure
class Client {
  Client({
    this.onError,
    this.onData,
    this.hostname,
    this.port,
  });

  String hostname;
  int port;
  Uint8ListCallback onData;
  DynamicCallback onError;
  bool connected = false;
  Socket socket;

//send the message (indexes in the mapPage.dart) to Server and add a new line
  write(String message) {
    //Connect standard in to the socket
    socket.write(message + '\n');
  }

//disconnect to the Server
  disconnect() {
    if (socket != null) {
      socket.destroy();
      connected = false;
    }
  }
}
