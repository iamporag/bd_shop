import 'package:bd_shop/src/data/repository/profile_repository.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            //   if (state is ProfileInitial) {
            //     return CircularProgressIndicator();
            //   } else {
            //     return Text(context.);
            //   }
            // })

             FutureBuilder(
              future: ProfileRepository().getUserInfo(),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if(snapshot.hasError){
               return Center(child: Text("${snapshot.error}"),);
                }else {
                  var data = snapshot.data;
                  return  Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(data!.profilePicUrl),
                                    ),
                      ),
                      Text(data.fullName),
                      Text(data.email),
                      Text(data.phoneNumber),
                      Text(data.uid),

                    ],
                  );
                }
              }
              )
          ],
        ),
      ),
    );
  }
}
