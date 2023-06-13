import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notesapp/app/router/app_pages.dart';
import 'package:notesapp/app/util/const.dart';

class BottomNavigationBarHome extends StatelessWidget {
  const BottomNavigationBarHome({
    super.key,
    required this.mediaQuery,
    required this.itemCount,
  });

  final MediaQueryData mediaQuery;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: platformAndroid ? 50 : 90,
      padding: EdgeInsets.only(
        bottom: mediaQuery.padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 241, 241, 241),
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 0.1,
          ),
        ),
      ),
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Center(
            child: Text(
              '${itemCount.toString()} Notes',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              padding: const EdgeInsets.only(right: 30, bottom: 5),
              onPressed: () {
                context.goNamed(Routes.note, queryParameters: {
                  'index': '0',
                });
              },
              splashRadius: 10,
              icon: const Icon(
                Icons.add_box_outlined,
                size: 32,
                color: KColor1,
              ),
            ),
          )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Spacer(),
          //     Text(
          //       '0 Notes',
          //       style: TextStyle(
          //         fontSize: 13,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //     Spacer(),
          //     IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.add_box_outlined,
          //         color: KColor1,
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
