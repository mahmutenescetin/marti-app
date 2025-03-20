import 'package:flutter/material.dart';
import 'package:marti_app/core/base_view/scaffold_view.dart';
import 'package:marti_app/core/theme/context_extension.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldView(
      appBarTitle: 'Maps',
      body: Stack(
        children: [
          Container(
            color: context.backgroundColor,
            child: const Center(
              child: Text('Maps will be here'),
            ),
          ),

        ],
      ),
    );
  }
}
