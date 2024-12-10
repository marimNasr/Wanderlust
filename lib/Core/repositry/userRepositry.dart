// import 'package:dartz/dartz.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:mastering_api/core/API/APIConsumer.dart';
// import 'package:mastering_api/core/models/HotelsModel.dart';
// import 'package:mastering_api/core/models/logoutResponseModel.dart';
//
// import '../API/Endpoints.dart';
// import '../database/cacheHelper.dart';
// import '../errors/Exception.dart';
// import '../functions/uploadImageToAPI.dart';
// import '../models/SignupResponseModel.dart';
// import '../models/signinResponseModel.dart';
//
// class userRepositry {
//   final APIConsumer api;
//   userRepositry(this.api);
//
//   Future<Either<String, SignInModel>> signIn({required String email, required String pass}) async{
//     try {
//       final response = await api.post(Endpoints.signIn, data: {
//         ApiKeys.email: email,
//         ApiKeys.password: pass
//       });
//       final SignedUser = SignInModel.fromJson(response);
//       final DecodedToken = JwtDecoder.decode(SignedUser.token);
//       Cachehelper.setData(key: ApiKeys.token, value: SignedUser.token);
//       Cachehelper.setData(key: ApiKeys.id, value: DecodedToken[ApiKeys.id]);
//       return Right(SignedUser);
//     }on ServerException catch(e){
//       return Left(e.errorModel.message);
//     }
//   }
//
//   Future<Either<String,signupModel>> signUp({required String name, required String phone, required String email, required String pass, required String cpass, required XFile? profileImage}) async{
//     try {
//       Cachehelper.clearData();
//       final response = await api.post(Endpoints.signUp, isFormData: true,
//           data: {
//             ApiKeys.name : name,
//             ApiKeys.email : email,
//             ApiKeys.password : pass,
//             ApiKeys.phone : phone,
//             ApiKeys.confirmPassword : cpass,
//             ApiKeys.location : '''{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}''',
//             ApiKeys.profilePic : uploadImageToAPI(profileImage!)
//           });
//       final newUser = signupModel.fromJson(response);
//       Cachehelper.setData(key: ApiKeys.name, value: name);
//       Cachehelper.setData(key: ApiKeys.phone, value: phone);
//       print("\n\nkgsdahilUHASDJ ${profileImage.path}\n\n");
//       return Right(newUser);
//     } on ServerException catch (e) {
//       return Left(e.errorModel.message);
//     }
//   }
//
//   Future<Either<String, getUserModel>> getUser(String? id) async{
//     try{
//       final response = await api.get(Endpoints.getUser+id!);
//       final userData = getUserModel.fromJson(response);
//       return Right(userData);
//     }on ServerException catch(e){
//       return Left(e.errorModel.message);
//     }
//   }
//
//   Future<Either<String, logoutModel>> logOut() async{
//     try{
//       final response = await api.get(Endpoints.logout);
//       final logoutUser = logoutModel.fromJson(response);
//       return Right(logoutUser);
//     }on ServerException catch (e){
//       return Left(e.errorModel.message);
//     }
//   }
// }
//
