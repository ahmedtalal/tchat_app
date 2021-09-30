import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchat/firebase/chat/follow_crud_Services.dart';
import 'package:tchat/firebase/chat/follower_crud_Services.dart';
import 'package:tchat/models/post_model.dart';
import 'package:tchat/providers/bloc/follow_bloc/follow_Events.dart';
import 'package:tchat/providers/bloc/follow_bloc/follow_States.dart';

class FollowBloc extends Bloc<FollowEvents, FollowStates> {
  var ownerId;
  FollowBloc() : super(FollowInitialState());

  @override
  Stream<FollowStates> mapEventToState(FollowEvents event) async* {
    if (event is AddFollowEvent) {
      try {
        var result = await FollowCrudServices.getInstance().addData(ownerId);
        if (result == true) {
          var followerResult =
              await FollowerCrudServices.getInstance().addData(ownerId);
          if (followerResult == true) {
            yield FollowedState(message: "successfully added operation");
          } else {
            yield FollowExceptionState(error: "error in adding operation");
          }
        } else {
          yield FollowExceptionState(error: "error in adding operation");
        }
      } catch (e) {
        yield FollowExceptionState(error: "error in adding operation");
      }
    } else if (event is RemoveFollowEvents) {
      try {
        var result = await FollowCrudServices.getInstance().deleteData(ownerId);
        if (result == true) {
          var followerResult =
              await FollowerCrudServices.getInstance().deleteData(ownerId);
          if (followerResult == true) {
            yield FollowedState(message: "successfully  remove operation");
          } else {
            yield FollowExceptionState(error: "error in reomove operation");
          }
        } else {
          yield FollowExceptionState(error: "error in reomove operation");
        }
      } catch (e) {
        yield FollowExceptionState(error: "error in adding operation");
      }
    }
  }

  // void addFollowingUser(PostModel postModel) async {
  //   String ownerId = postModel.ownerId;
  //   var result = await FollowCrudServices.getInstance().addData(ownerId);
  //   var followerResult =
  //       await FollowerCrudServices.getInstance().addData(ownerId);
  //   if (result == true || followerResult == true) {
  //     print("successfully added operation");
  //   } else {
  //     print("error in adding operation");
  //   }
  // }

  // void removeFollowingUser(PostModel postModel) async {
  //   String ownerId = postModel.ownerId;
  //   var result = await FollowCrudServices.getInstance().deleteData(ownerId);
  //   var followerResult =
  //       await FollowerCrudServices.getInstance().deleteData(ownerId);
  //   if (result == true || followerResult == true) {
  //     print("successfully  remove operation");
  //   } else {
  //     print("error in reomove operation");
  //   }
  // }
}
