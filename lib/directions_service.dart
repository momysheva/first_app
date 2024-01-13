import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectionsService {
  static Future<List<Map<String, dynamic>>> getDirections(
      double originLat, double originLng, double destLat, double destLng, String apiKey) async {
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLng&destination=$destLat,$destLng&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      if (decodedData['status'] == 'OK') {
        return decodedData['routes'][0]['legs'][0]['steps']
            .map<Map<String, dynamic>>((step) => {
                  'instruction': step['html_instructions'],
                  'distance': step['distance']['text'],
                })
            .toList();
      } else {
        throw Exception(decodedData['error_message'] ?? 'Failed to fetch directions');
      }
    } else {
      throw Exception('Failed to fetch directions');
    }
  }
}
