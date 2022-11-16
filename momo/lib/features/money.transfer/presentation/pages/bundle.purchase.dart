import 'package:flutter/material.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';

import '../../../../core/constants.dart';

// part 'bundles/';
// part 'bundles/';
// part 'bundles/';
// part 'bundles/';

class BundlePurchasePage extends StatefulWidget {
  const BundlePurchasePage({Key? key}) : super(key: key);

  @override
  State<BundlePurchasePage> createState() => _BundlePurchasePageState();
}

class _BundlePurchasePageState extends State<BundlePurchasePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colorScheme.primary,
        appBar: AppBar(
            backgroundColor:
                context.colorScheme.primary.withOpacity(kEmphasisNone)),
        body: LoadingOverlay(
          child: Container(),
        ),
      );
}
