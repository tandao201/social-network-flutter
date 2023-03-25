import 'dart:convert';
import 'package:chat_app_flutter/models/commons/spotify_music_response.dart';
import 'package:dio/dio.dart';

class SpotifyMusic {
  static String clientId = "3b1b5d4a77e644c2929b10626bb85e4d";
  static String clientSecret = "d8db8ee7c9cf47ddb31c799829b18b7a";
  static Dio dio = Dio();
  static Future<String> getAccessToken() async {
    var url = 'https://accounts.spotify.com/api/token';
    var headers = {
      // 'Authorization': 'Basic <base64-encoded $clientId:$clientSecret>',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var body = {
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret
    };
    var response = await dio.post(url, data: body, options: Options(headers: headers));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      print('Access token: ${data['access_token']}');
      return data['access_token'];
    } else {
      print('Response: ${response.statusCode}');
      throw Exception('Failed to get access token');
    }
  }

  static Future<List<Items>> searchSong(String query) async {
    var accessToken = await getAccessToken();
    var url = 'https://api.spotify.com/v1/search?q=$query&type=track&limit=10';
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    var response = await dio.get(url, options: Options(headers: headers));

    if (response.statusCode == 200) {
      SpotifyMusicResponse spotifyMusic = SpotifyMusicResponse.fromJson(response.data);
      print('Data song:');
      for( var song in spotifyMusic.tracks!.items!) {
        print('Song name: ${song.name} - ${song.artists?[0].name}');
      }
      List<Items> songs = spotifyMusic.tracks?.items ?? [];
      return songs;
    } else {
      throw Exception('Failed to search for song');
    }
  }
}

