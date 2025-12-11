import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomAlertDialog {
  static showPresenceAlertL({
    String? title,
    String? message,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
    required void Function() onConfirm,
    required void Function() onCancel,
    required BuildContext context,
  }) {
    Get.defaultDialog(
      backgroundColor: Color(0xff2F2F2F),
      cancelTextColor: Colors.red,
      confirmTextColor: Colors.white,
      title: "",
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      radius: 12,
      titlePadding: EdgeInsets.zero,
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        mainAxisSize:
        MainAxisSize.min,
        children: [

          Icon(
            Icons.warning_amber_outlined,
            size: 50,
            color: Color(0xffCFED51),
          ),
          if (title != null)
            const SizedBox(height: 16),
          if (title != null)
            Text(
              title,
              style:TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold)
            ),
          const SizedBox(height: 8),

          if (message != null)
            Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400,fontFamily: 'Instrument Sans'),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Cancel Button
              Visibility(
                visible: cancelText.isNotEmpty,
                child: InkWell(
                  onTap: () {
                    Get.back();
                    onCancel();
                    onCancel();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      cancelText,
                      style: TextStyle(fontSize: 12,color: Colors.black, fontWeight: FontWeight.w600,fontFamily: 'Instrument Sans')
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Visibility(
                visible: confirmText.isNotEmpty,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: onConfirm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xffCFED51),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        confirmText,
                        style: TextStyle(fontSize: 12,color: Colors.black, fontWeight: FontWeight.w600,fontFamily: 'Instrument Sans')
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}