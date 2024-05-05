import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'storage.dart';

import 'package:http/http.dart' as http;

saveSessionCookie(String cookie){
  var useString = cookie;
  if(useString.contains("connect.sid=")){
    useString = useString.split("connect.sid=")[1];
    useString = useString.split(";")[0];
  }

  print(useString);

  var existing = "";
  if(getPreferences().containsKey("session")){
    existing = getPreferences().getString("session")!;
  }


  if(existing != useString){
    getPreferences().setString("session", useString);
  }
}

String getSessionCookie(){
  var useString = "connect.sid=";

  if(getPreferences().containsKey("session")){
    useString += getPreferences().getString("session")!;
  }else{
    useString = "";
  }


  return useString;


}


Future<Map<String, dynamic>> _apiGet(String path) async {


  final res = await http.get(
      Uri.parse("https://pep.robosmrt.com/" + path),
    headers: {
        "cookie": getSessionCookie()
    }
  );

  print(res.headers);

  if(res.headers.containsKey("set-cookie")){
    saveSessionCookie(res.headers["set-cookie"]!);
  }

  final responseJSON = jsonDecode(res.body) as Map<String, dynamic>;
  if(res.statusCode != 200){
    // If status code isn't 200, then we need to give details about the error
    responseJSON["_error"] = true;
    responseJSON["_statusCode"] = res.statusCode;
  }

  return responseJSON;
}

Future<Map<String, dynamic>> _apiPost(String path, Map<String, dynamic> data) async {
  final res = await http.post(
      Uri.parse("https://pep.robosmrt.com/" + path),
      body: data,
      headers: {
        "cookie": getSessionCookie()
      }
  );

  final responseJSON = jsonDecode(res.body) as Map<String, dynamic>;
  if(res.statusCode != 200){
    // If status code isn't 200, then we need to give details about the error
    responseJSON["_error"] = true;
    responseJSON["_statusCode"] = res.statusCode;
  }

  return responseJSON;
}

Future<Map<String, dynamic>> validateToken(String token) async{

  return _apiGet("account/validate?token=" + token);

}

Future<Map<String, dynamic>> fetchEvents() async{

  return _apiGet("api/event/list");

}

Future<Map<String, dynamic>> fetchUsers() async{

  return _apiGet("api/identity/users");

}

Future<Map<String, dynamic>> fetchAPI() async {
  return _apiGet("api/");
}

