class NasaEndpoints {
  static String apod({required String apiKey, required String date}) => "https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$date";
}