
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:smartcanteen/service/shared_preferences_service.dart';

// class ShopCard extends StatelessWidget {
//   final String shopName;
//   final String category;
//   final bool isOpen;
//   final String estimatedTime;
//   final VoidCallback? onTap;

//   const ShopCard({
//     super.key,
//     required this.shopName,
//     required this.category,
//     required this.isOpen,
//     required this.estimatedTime,
//     this.onTap,
//   });

//   static const Color primaryColor = Color(0xff117992);

//   /// Guard action to ensure user is logged in
//   Future<void> _handleViewMenu(BuildContext context) async {
//     final currentUser = await SharedPreferencesService.getUser();
//     if (context.mounted) {
//       if (currentUser == null) {
//         context.go('/login');
//       } else {
//         onTap?.call();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: isOpen ? 1.0 : 0.6,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xff117992).withOpacity(0.06),
//               blurRadius: 16,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               /// TOP SHOP INFO
//               Row(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(18),
//                       child: Image.asset(
//                         "assets/image/chef.jpg",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 shopName,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: isOpen
//                                       ? const Color(0xff1E293B)
//                                       : Colors.grey.shade600,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 3,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: isOpen
//                                     ? const Color(0xff10B981).withOpacity(0.1)
//                                     : const Color(0xffEF4444).withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 isOpen ? "Open" : "Closed",
//                                 style: TextStyle(
//                                   color: isOpen
//                                       ? const Color(0xff059669)
//                                       : const Color(0xffDC2626),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 11,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           category,
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               /// BOTTOM BUTTON
//               SizedBox(
//                 width: double.infinity,
//                 height: 38,
//                 child: ElevatedButton(
//                   onPressed: isOpen ? () => _handleViewMenu(context) : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     disabledBackgroundColor: Colors.grey.shade300,
//                     side: BorderSide(
//                       color: isOpen
//                           ? const Color(0xff117992)
//                           : Colors.grey.shade400,
//                       width: 1.5,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: Text(
//                     isOpen ? "View Menu" : "Shop Closed",
//                     style: TextStyle(
//                       color: isOpen
//                           ? const Color(0xff117992)
//                           : Colors.grey.shade600,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
// Remove 'package:go_router/go_router.dart' if it's no longer used elsewhere in this file
import 'package:smartcanteen/service/shared_preferences_service.dart';

class ShopCard extends StatelessWidget {
  final String shopName;
  final String category;
  final bool isOpen;
  final String estimatedTime;
  final VoidCallback? onTap;

  const ShopCard({
    super.key,
    required this.shopName,
    required this.category,
    required this.isOpen,
    required this.estimatedTime,
    this.onTap,
  });

  static const Color primaryColor = Color(0xff117992);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isOpen ? 1.0 : 0.6,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff117992).withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              /// TOP SHOP INFO
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        "assets/image/chef.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                shopName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isOpen
                                      ? const Color(0xff1E293B)
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: isOpen
                                    ? const Color(0xff10B981).withOpacity(0.1)
                                    : const Color(0xffEF4444).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                isOpen ? "ဆိုင်ဖွင့်သည်" : "ဆိုင်ပိတ်သည်",
                                style: TextStyle(
                                  color: isOpen
                                      ? const Color(0xff059669)
                                      : const Color(0xffDC2626),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// BOTTOM BUTTON - Allows anyone to view shop details & menus
              SizedBox(
                width: double.infinity,
                height: 38,
                child: ElevatedButton(
                  // Directly execute onTap without checking user status login restrictions
                  onPressed: isOpen ? () => onTap?.call() : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    side: BorderSide(
                      color: isOpen
                          ? const Color(0xff117992)
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isOpen ? "မီနူးကြည့်ရန်" : "မီနူးကြည့်ရန်",
                    style: TextStyle(
                      color: isOpen
                          ? const Color(0xff117992)
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}