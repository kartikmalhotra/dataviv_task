import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:task/config/screen_config.dart';
import 'package:task/providers/user_post_provider.dart';
import 'package:task/shared/models/user_post_model.dart';
import 'package:flutter/material.dart';

class DisplayPostScreen extends StatefulWidget {
  final UserPost post;

  const DisplayPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  _DisplayPostScreenState createState() => _DisplayPostScreenState();
}

class _DisplayPostScreenState extends State<DisplayPostScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: AppScreenConfig.getScreenWidth(),
        height: AppScreenConfig.getScreenHeight(),
        color: Colors.white,
        child: Column(
          children: [
            _showPostedUserImage(),
            SizedBox(height: AppSpacing.xss),
            _showProductDescription()
          ],
        ),
      ),
    );
  }

  Widget _showProductDescription() {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _showActionsOnImage(widget.post),
              const Divider(),
              _showPostedUserInfo(),
              _displayDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayDescription() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Description",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: AppSpacing.l,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.post.description ?? "Description not available",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showPostedUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.post.urls?.thumb != null
                  ? CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: "${widget.post.user?.profileImage?.small}",
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
                  Text("${widget.post.user?.firstName}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(widget.post.user?.location ?? "",
                      style: Theme.of(context).textTheme.caption!),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _showPostedUserImage() {
    return Container(
      height: 400,
      child: Image.network(
        widget.post.urls!.regular!,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!.toInt()
                  : null,
            ),
          );
        },
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
}
