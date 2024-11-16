import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/widgets/dialogs/add_a_location_dialog.dart';
import 'package:saree/widgets/dialogs/delete_location_dialog.dart';
import 'package:saree/widgets/dialogs/submit_user_info_dialog.dart';

import '../../config/responsive_font.dart';
import '../../config/theme.dart';
import '../../providers/location_provider.dart';

class SelectLocationWidget extends StatefulWidget {
  final PageController pageController;
  final bool isBuying;

  const SelectLocationWidget(this.pageController,
      {this.isBuying = false, super.key});

  @override
  State<SelectLocationWidget> createState() => _SelectLocationWidgetState();
}

class _SelectLocationWidgetState extends State<SelectLocationWidget> {
  @override
  void initState() {
    Provider.of<LocationProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("اختر موقعك"),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Consumer<LocationProvider>(
            builder: (_, provider, child) {
              if (provider.locations.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text("no locations added")),
                );
              } else {
                return SliverList.builder(
                  itemBuilder: (_, i) => RadioListTile(
                    value: provider.locations[i],
                    groupValue: provider.selectedLocation,
                    onChanged: (val) => provider.selectLocation(val!),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.locations[i].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getResponsiveFontSize(context, 22),
                              ),
                            ),
                            Text(
                              provider.locations[i].details,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: getResponsiveFontSize(context, 14),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) =>
                                DeleteLocationDialog(provider.locations[i]),
                          ),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: provider.locations.length,
                );
              }
            },
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => widget.pageController.nextPage(
                    duration: Durations.medium2,
                    curve: Curves.easeInOutCubic,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: MyTheme.primary,
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      "اضافة عنوان",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: getResponsiveFontSize(context, 24),
                      ),
                    ),
                  ),
                ),
                widget.isBuying
                    ? GestureDetector(
                        onTap: () {
                          if (Provider.of<LocationProvider>(context,
                                      listen: false)
                                  .selectedLocation ==
                              null) {
                            showDialog(context: context, builder: (_) => const AddALocationDialog());
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => const SubmitUserInfoDialog(),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          margin: const EdgeInsets.only(top: 16),
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MyTheme.primary,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            "تأكيد",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: getResponsiveFontSize(context, 24),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
