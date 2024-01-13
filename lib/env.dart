import 'package:http/http.dart' as http;

Future<bool> checkConnection() async {
  try {
    final response = await http.get(Uri.parse('http://10.110.105.112:8000/mobile_login'));

    return response.statusCode == 200;
  } catch (error) {
    return false;
  }
}

void main() async {
  bool isConnected = await checkConnection();

  if (isConnected) {
    print('Connected to the server!');
    // Continue with your app logic
  } else {
    print('Failed to connect to the server.');
    // Handle the lack of connection, show an error message, etc.
  }
}
