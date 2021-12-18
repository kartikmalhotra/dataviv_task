import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/config/routes/routes_const.dart';
import 'package:task/config/screen_config.dart';
import 'package:task/providers/user_post_provider.dart';
import 'package:task/shared/models/user_post_model.dart';

class FavourateScreen extends StatefulWidget {
  const FavourateScreen({Key? key}) : super(key: key);

  @override
  _FavourateScreenState createState() => _FavourateScreenState();
}

class _FavourateScreenState extends State<FavourateScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<UserPostProvider>(context, listen: false).getFavouratePost();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserPostProvider>(
      builder: (_, value, __) {
        if (value.favouratePost.isNotEmpty) {
          return _displayFavourateScreen(value.favouratePost);
        }
        return Center(child: Text("No Favourate Post Present"));
      },
    );
  }

  Widget _displayFavourateScreen(List<UserPost> favourateList) {
    return Container(
      color: Colors.white,
      width: AppScreenConfig.getScreenWidth(),
      height: AppScreenConfig.getScreenHeight(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _showAppBar(),
          Divider(color: Colors.black, thickness: 0.5),
          _displayFavouratePost(favourateList),
        ],
      ),
    );
  }

  Widget _displayFavouratePost(List<UserPost> favouratePost) {
    return Expanded(
      child: Container(
        height: double.maxFinite,
        child: ListView.builder(
          itemCount: favouratePost.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productDetailScreen,
                  arguments: favouratePost[index],
                );
              },
              child: _showPost(favouratePost[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _showAppBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Favourate", style: Theme.of(context).textTheme.headline6),
        ],
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
          Divider(color: Colors.black, thickness: 0.5),
          _showPostedUserImage(userPost),
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
              ? Icon(Icons.favorite, color: Colors.pink)
              : Icon(Icons.favorite_outline, color: Colors.black),
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
