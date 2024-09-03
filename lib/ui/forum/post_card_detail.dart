// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:guethub/data/model/app/forum/forum_posts_response/forum_posts_response.dart';
// import 'package:guethub/ui/page/image_list_view/image_list_view.dart';
// import 'package:guethub/ui/route.dart';
// import 'package:guethub/ui/util/toast.dart';
// import 'package:guethub/ui/widget/image_view.dart';
// import 'package:intl/intl.dart';
//
// import 'post_card.dart';
// import 'post_detail_controller.dart';
// import 'send_post_page.dart';
//
// class PostCardDetail extends StatefulWidget {
//   PostCardDetail(
//       {super.key,
//       required this.post,
//       required this.viewsCount,
//       required this.onChangeLikePost});
//
//   final ForumPost post;
//   final OnChangeLikePost onChangeLikePost;
//   final Rx<int> viewsCount;
//
//   @override
//   State<PostCardDetail> createState() => _PostCardDetailState();
// }
//
// class _PostCardDetailState extends State<PostCardDetail> {
//   final datetimeFormat = DateFormat("yyyy-MM-dd HH:mm");
//
//   @override
//   Widget build(BuildContext context) {
//     final c = Get.find<PostDetailController>(tag: widget.post.id);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipOval(
//                   child: CachedNetworkImage(
//                     imageUrl: imageBaseUrl + widget.post.userProfile.avatar,
//                     width: 36,
//                     height: 36,
//                     fit: BoxFit.cover,
//                     errorWidget: (c, url, error) {
//                       return Image.asset(
//                         "assets/images/logo.png",
//                         width: 36,
//                         height: 36,
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Text(
//                   widget.post.userProfile.nickname,
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (widget.post.text.isNotEmpty)
//                   SelectableText(
//                     widget.post.text,
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 if (widget.post.images.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 15.0),
//                     child: _buildImageGrid(),
//                   ),
//               ],
//             ),
//           ),
//           if (widget.post.ipCity != null)
//             Container(
//                 padding: EdgeInsets.only(top: 8, left: 16, bottom: 8),
//                 child: Text("ip: " + widget.post.ipCity!,
//                     style: TextStyle(color: Colors.grey))),
//           if (widget.post.address != null)
//             Container(
//               padding: EdgeInsets.all(8),
//               child: Row(children: [
//                 Icon(Icons.location_on_outlined),
//                 SizedBox(width: 8),
//                 Flexible(child: Text(widget.post.address!))
//               ]),
//             ),
//           if (widget.post.address == null) SizedBox(height: 4),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   datetimeFormat
//                       .format(DateTime.parse(widget.post.createdAt).toLocal()),
//                   style: TextStyle(
//                     fontSize: 15,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Container(
//                     width: 5,
//                     height: 5,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.onSurface,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Obx(() => Text(
//                       widget.viewsCount.toString(),
//                       style: TextStyle(
//                           color: Theme.of(context).colorScheme.onSurface,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold),
//                     )),
//                 Text(
//                   '查看',
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Container(
//                     width: 5,
//                     height: 5,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.onSurface,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '${widget.post.likesCount} ',
//                   style: TextStyle(
//                       color: Theme.of(context).colorScheme.onSurface,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '喜欢',
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             color: Colors.grey,
//             width: double.infinity,
//             height: 0.2,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Get.toNamed(AppRoute.sendPostPage,
//                       arguments: SendPostPageArgs(
//                           text: c.replyController.text,
//                           parentPost: widget.post));
//                 },
//                 icon: Icon(Icons.messenger_outline_rounded),
//               ),
//               IconButton(
//                 onPressed: () async {
//                   final result =
//                       await widget.onChangeLikePost(widget.post.isLiked);
//                   setState(() {
//                     widget.post.isLiked = result;
//                     widget.post.likesCount =
//                         widget.post.likesCount + (result ? 1 : -1);
//                   });
//                 },
//                 icon: widget.post.isLiked
//                     ? Icon(
//                         Icons.favorite,
//                         color: Colors.red,
//                       )
//                     : Icon(Icons.favorite_border_outlined),
//               ),
//             ],
//           ),
//           Container(
//             color: Colors.grey,
//             width: double.infinity,
//             height: 0.2,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildImageGrid() {
//     int imageCount = widget.post.images.length;
//
//     if (imageCount == 1) {
//       return ImageWidget(
//         imageUrl: widget.post.images.first,
//         imageList: widget.post.images,
//         initialIndex: 0,
//       );
//     } else if (imageCount == 2) {
//       return Row(
//         children: widget.post.images
//             .asMap()
//             .entries
//             .map((entry) => Expanded(
//                   child: ImageWidget(
//                     imageUrl: entry.value,
//                     imageList: widget.post.images,
//                     initialIndex: entry.key,
//                   ),
//                 ))
//             .toList(),
//       );
//     } else if (imageCount == 3) {
//       return Column(
//         children: [
//           Row(
//             children: widget.post.images
//                 .take(2)
//                 .toList()
//                 .asMap()
//                 .entries
//                 .map((entry) => Expanded(
//                       child: ImageWidget(
//                         imageUrl: entry.value,
//                         imageList: widget.post.images,
//                         initialIndex: entry.key,
//                       ),
//                     ))
//                 .toList(),
//           ),
//           ImageWidget(
//             imageUrl: widget.post.images[2],
//             imageList: widget.post.images,
//             initialIndex: 2,
//           ),
//         ],
//       );
//     } else if (imageCount == 4) {
//       return Column(
//         children: [
//           Row(
//             children: widget.post.images
//                 .take(2)
//                 .toList()
//                 .asMap()
//                 .entries
//                 .map((entry) => Expanded(
//                       child: ImageWidget(
//                         imageUrl: entry.value,
//                         imageList: widget.post.images,
//                         initialIndex: entry.key,
//                       ),
//                     ))
//                 .toList(),
//           ),
//           Row(
//             children: widget.post.images
//                 .skip(2)
//                 .take(2)
//                 .toList()
//                 .asMap()
//                 .entries
//                 .map((entry) => Expanded(
//                       child: ImageWidget(
//                         imageUrl: entry.value,
//                         imageList: widget.post.images,
//                         initialIndex: entry.key + 2,
//                       ),
//                     ))
//                 .toList(),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         children: [
//           Row(
//             children: widget.post.images
//                 .take(2)
//                 .toList()
//                 .asMap()
//                 .entries
//                 .map((entry) => Expanded(
//                       child: ImageWidget(
//                         imageUrl: entry.value,
//                         imageList: widget.post.images,
//                         initialIndex: entry.key,
//                       ),
//                     ))
//                 .toList(),
//           ),
//           Row(
//             children: widget.post.images
//                 .skip(2)
//                 .take(2)
//                 .toList()
//                 .asMap()
//                 .entries
//                 .map((entry) => Expanded(
//                       child: ImageWidget(
//                         imageUrl: entry.value,
//                         imageList: widget.post.images,
//                         initialIndex: entry.key + 2,
//                       ),
//                     ))
//                 .toList(),
//           ),
//           if (imageCount > 4)
//             OverlayImageWidget(
//               imageUrl: widget.post.images[4],
//               remainingCount: imageCount - 4,
//               imageList: widget.post.images,
//               initialIndex: 4,
//             ),
//         ],
//       );
//     }
//   }
// }
//
// class ImageWidget extends StatelessWidget {
//   final String imageUrl;
//   final List<String> imageList;
//   final int initialIndex;
//
//   const ImageWidget({
//     Key? key,
//     required this.imageUrl,
//     required this.imageList,
//     required this.initialIndex,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.0, // Set a fixed aspect ratio
//       child: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(8),
//           onTap: () {
//             Get.toNamed(
//               AppRoute.imageListViewer,
//               arguments: ImageListViewerArgs(
//                 imageList: imageList,
//                 initialIndex: initialIndex,
//               ),
//             );
//           },
//           child: Hero(
//             tag: imageUrl,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: CachedNetworkImage(
//                 imageUrl: imageUrl,
//                 fit: BoxFit.cover,
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class OverlayImageWidget extends StatelessWidget {
//   final String imageUrl;
//   final int remainingCount;
//   final List<String> imageList;
//   final int initialIndex;
//
//   const OverlayImageWidget({
//     Key? key,
//     required this.imageUrl,
//     required this.remainingCount,
//     required this.imageList,
//     required this.initialIndex,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Image layer, ensures image is clickable
//         InkWell(
//           onTap: () {
//             Get.toNamed(
//               AppRoute.imageListViewer,
//               arguments: ImageListViewerArgs(
//                 imageList: imageList,
//                 initialIndex: initialIndex,
//               ),
//             );
//           },
//           child: Hero(
//             tag: imageUrl,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: CachedNetworkImage(
//                 imageUrl: imageUrl,
//                 fit: BoxFit.cover,
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//           ),
//         ),
//         // Overlay layer to display the number of remaining images
//         Positioned.fill(
//           child: InkWell(
//             onTap: () {
//               Get.toNamed(
//                 AppRoute.imageListViewer,
//                 arguments: ImageListViewerArgs(
//                   imageList: imageList,
//                   initialIndex: initialIndex,
//                 ),
//               );
//             },
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Container(
//                 alignment: Alignment.center,
//                 color: Colors.black54.withOpacity(0.5), // Overlay transparency
//                 child: Text(
//                   '+$remainingCount',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }