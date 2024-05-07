import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:mapstagram/src/components/avatar_widget.dart';
import 'package:mapstagram/src/components/image_data.dart';
import 'package:mapstagram/src/models/post.dart';
import 'package:timeago/timeago.dart' as timeage;

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvartarWidget(
            type: AvatarType.TYPE3,
            nickname: post.userInfo!.nickname,
            size: 45,
            thumbPath: post.userInfo!.thumbnail!,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(
                IconsPath.likeOffIcon,
                width: 65,
              ),
              const SizedBox(
                width: 15,
              ),
              ImageData(
                IconsPath.replyIcon,
                width: 60,
              ),
              const SizedBox(
                width: 15,
              ),
              ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ],
          ),
          ImageData(
            IconsPath.bookMarkOffIcon,
            width: 50,
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
      imageUrl: post.thumbnail!,
    );
  }

  Widget _place() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('숭실 대학교'),
          Row(
            children: [
              Icon(Icons.star, color: Colors.blue, size: 16),
              Icon(Icons.star, color: Colors.blue, size: 16),
              Icon(Icons.star, color: Colors.blue, size: 16),
              Icon(Icons.star_half, color: Colors.blue, size: 16),
              Icon(Icons.star_border, color: Colors.blue, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '좋아요 ${post.likeCount ?? 0}개',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          ExpandableText(
            post.description ?? '',
            prefixText: post.userInfo!.nickname,
            onPrefixTap: () {
              print('개발하는 남자 페이지 이동');
            },
            prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
            expandText: '더보기',
            collapseText: '접기',
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return GestureDetector(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          '댓글 199개 모두 보기',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ),
    );
  }

  Widget _dateAgd() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        timeage.format(post.createdAt!),
        style: const TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const SizedBox(height: 15),
          _place(),
          const SizedBox(height: 15),
          _image(),
          const SizedBox(height: 15),
          _infoCount(),
          const SizedBox(height: 5),
          _infoDescription(),
          const SizedBox(height: 5),
          _replyTextBtn(),
          const SizedBox(height: 5),
          _dateAgd(),
        ],
      ),
    );
  }
}
