import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suscopts_flutter_starter/config.dart';
import 'package:suscopts_flutter_starter/library/user.dart';



// General Congregation (Logined User) Information
Future<String> general(String email, String password) async {
  User temp = await SavedUser();
  http.Response res = await http.post( Uri.encodeFull(api+'/general/'), 
                  body: json.encode({}), 
                  headers: {
                    'authorization': temp.getToken(),
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                    });
                    
  if (res.statusCode == 200) {
    return res.body;
  } else {
    return 'fail';
  }
} 

// Main Login: allows all members 

Future<String> login(String email, String password) async {
  http.Response res = await http.post( Uri.encodeFull('$api/login/'), 
                  body:  json.encode({'email': email, 'password': password}), 
                  headers: {
                    'authorization': basicAuth,
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                    });
                    
  if (res.statusCode == 200) {
    return res.body;
  } else {
    return 'fail';
  }
} 
/*
 Limit to going members to church. 
 All for any possible congregation and Main core members. 
 http://suscoptsapi.stmary.info/login/[all | main]/[churches_id]/

*/

// Future<String> login(String email, String password) async {
//   http.Response res = await http.post( Uri.encodeFull("$api/login/all/$churchid/"), 
//                   body:  json.encode({'email': email, 'password': password}), 
//                   headers: {
//                     'authorization': basicAuth,
//                     'Content-Type': 'application/json',
//                     'Accept': 'application/json'
//                     });
                    
//   if (res.statusCode == 200) {
//     return res.body;
//   } else {
//     return 'fail';
//   }
// } 

/*
  Limit to group
  http://suscoptsapi.stmary.info/login/group/[group_id]/
*/

// Future<String> login(String email, String password) async {
//   http.Response res = await http.post( Uri.encodeFull("$api/login/group/$groupid/"), 
//                   body:  json.encode({'email': email, 'password': password}), 
//                   headers: {
//                     'authorization': basicAuth,
//                     'Content-Type': 'application/json',
//                     'Accept': 'application/json'
//                     });
                    
//   if (res.statusCode == 200) {
//     return res.body;
//   } else {
//     return 'fail';
//   }
// } 
