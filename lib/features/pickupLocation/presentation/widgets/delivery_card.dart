// import 'package:flowery_tracking/features/pickupLocation/domain/entities/delivery_location.dart';
// import 'package:flutter/material.dart';
// import 'package:flowery_tracking/core/config/theme/app_colors.dart';
//
class DeliveryCard {}
//   final DeliveryLocation location;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final VoidCallback onPhoneCall;
//   final VoidCallback onWhatsApp;
//
//   const DeliveryCard({
//     Key? key,
//     required this.location,
//     required this.isSelected,
//     required this.onTap,
//     required this.onPhoneCall,
//     required this.onWhatsApp,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: const Color(0xFFE0E0E0),
//             width: 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Avatar
//             Container(
//               width: 48,
//               height: 48,
//               decoration: BoxDecoration(
//                 color: AppColorsLight.pink,
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: location.isStore
//                     ? const Icon(
//                   Icons.local_florist,
//                   color: AppColorsLight.white,
//                   size: 24,
//                 )
//                     : ClipOval(
//                   child: Image.network(
//                     location.imageUrl,
//                     width: 48,
//                     height: 48,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Icon(
//                         Icons.person,
//                         color: AppColorsLight.white,
//                         size: 24,
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             // Title and Address
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     location.title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xFF0c1015),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on_outlined,
//                         size: 16,
//                         color: Color(0xFF535353),
//                       ),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           location.address,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFF535353),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 8),
//             // Action Icons
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 color: AppColorsLight.pink.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 padding: EdgeInsets.zero,
//                 icon: const Icon(
//                   Icons.phone,
//                   color: AppColorsLight.pink,
//                   size: 18,
//                 ),
//                 onPressed: onPhoneCall,
//               ),
//             ),
//             const SizedBox(width: 8),
//             Container(
//               width: 36,
//               height: 36,
//               decoration: BoxDecoration(
//                 color: AppColorsLight.pink.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: IconButton(
//                 padding: EdgeInsets.zero,
//                 icon: const Icon(
//                   Icons.chat_bubble_outline,
//                   color: AppColorsLight.pink,
//                   size: 18,
//                 ),
//                 onPressed: onWhatsApp,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }