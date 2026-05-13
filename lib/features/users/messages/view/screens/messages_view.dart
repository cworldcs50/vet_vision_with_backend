import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../controller/messages_controller.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MessagesController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          "Messages",
          style: TextStyle(
            color: Colors.black,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 18,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 8,
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search messages...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey[500]),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (context, index) => Divider(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 1,
                ),
                color: Colors.grey[200],
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 16,
                    ),
                    vertical: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 8,
                    ),
                  ),
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 24,
                        ),
                        backgroundColor: AppColors.primaryColor.withValues(
                          alpha: 0.1,
                        ),
                        child: Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                          size: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      if (index == 0) // Unread dot mock
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                            height: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    "Dr. Doctor Name ${index + 1}",
                    style: TextStyle(
                      fontWeight: index == 0
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    "Thanks for scheduling the appointment!",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: index == 0 ? Colors.black87 : Colors.grey[600],
                    ),
                  ),
                  trailing: Text(
                    "10:4$index AM",
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
