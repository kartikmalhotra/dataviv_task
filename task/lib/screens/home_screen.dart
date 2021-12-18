import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:task/config/application.dart';
import 'package:task/config/routes/routes_const.dart';
import 'package:task/config/screen_config.dart';

import 'package:task/providers/user_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:task/shared/models/user_post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<UserPostProvider>(context, listen: false).fetchUserPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserPostProvider>(
      builder: (context, value, __) {
        if (value.getFetchedData != null) {
          if (value.getFetchedData is! Exception) {
            return _displayHomeScreen(
                context, value.getFetchedData as UserPostModel);
          } else if (value.getFetchedData is Exception) {
            return Center(child: Text("${value.getFetchedData.message}"));
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _displayHomeScreen(BuildContext context, UserPostModel userPostModel) {
    return Container(
      color: Colors.white,
      width: AppScreenConfig.getScreenWidth(),
      height: AppScreenConfig.getScreenHeight(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _showAppBar(),
          Divider(color: Colors.black, thickness: 0.2),
          _showUserPost(userPostModel),
        ],
      ),
    );
  }

  Widget _showAppBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: "${InstaUser.photoUrl}",
            errorWidget: (context, _, __) => Container(),
            imageBuilder: (context, imageProvider) => Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
          ),
          Text(InstaUser.userName ?? ""),
        ],
      ),
    );
  }

  Widget _showUserPost(UserPostModel userPostModel) {
    return Expanded(
      child: Container(
        height: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: userPostModel.userPostModel?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productDetailScreen,
                  arguments: userPostModel.userPostModel![index],
                );
              },
              child: _showPost(userPostModel.userPostModel![index]),
            );
          },
        ),
      ),
    );
  }

  Widget _showPost(UserPost userPost) {
    return Container(
      height: 500,
      padding: EdgeInsets.only(bottom: 40.0),
      width: double.maxFinite,
      child: Column(
        children: [
          _showPostedUserInfo(userPost),
          Divider(
            color: Colors.black,
            thickness: 0.5,
            height: 1,
          ),
          _showPostedUserImage(userPost),
          SizedBox(height: AppSpacing.xss),
          _showActionsOnImage(userPost),
          _showImageInfo(userPost),
        ],
      ),
    );
  }

  Widget _showPostedUserInfo(UserPost userPost) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              userPost.urls?.thumb != null
                  ? CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: "${userPost.user?.profileImage?.small}",
                      errorWidget: (context, _, __) => Container(),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${userPost.user?.firstName}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(userPost.user?.location ?? "",
                      style: Theme.of(context).textTheme.caption!),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _showPostedUserImage(UserPost userPost) {
    return Expanded(
      child: Container(
        child: userPost.urls?.raw != null
            ? CachedNetworkImage(
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, progress) =>
                    Container(),
                errorWidget: (context, _, __) => Container(),
                imageUrl: "${userPost.urls?.regular}",
              )
            : Container(),
      ),
    );
  }

  Widget _showActionsOnImage(UserPost userpost) {
    return Row(
      children: [
        IconButton(
          icon: userpost.likedByUser
              ? Icon(Icons.thumb_up, size: 31)
              : Icon(Icons.thumb_up_alt_outlined, size: 31),
          color: Colors.black,
          onPressed: () {
            setState(() {
              userpost.likedByUser = !userpost.likedByUser;
              Provider.of<UserPostProvider>(context, listen: false)
                  .likeThePost();
            });
          },
        ),
        IconButton(
          icon: userpost.isFavourate
              ? Icon(Icons.favorite, color: Colors.pink, size: 31)
              : Icon(Icons.favorite_outline, color: Colors.black, size: 31),
          color: Colors.black,
          onPressed: () {
            setState(() {
              userpost.isFavourate = !userpost.isFavourate;
              Provider.of<UserPostProvider>(context, listen: false)
                  .addPostToFavourate(userpost);
            });
          },
        ),
      ],
    );
  }

  Widget _showImageInfo(UserPost userPost) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("${userPost.likes} Likes",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
