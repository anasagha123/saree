import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/config/device_size.dart';
import 'package:saree/config/theme.dart';
import 'package:saree/providers/search_store_provider.dart';
import 'package:saree/widgets/components/store_card.dart';

class SearchStoresScreen extends StatefulWidget {
  static const routeName = "/search-stores";

  const SearchStoresScreen({super.key});

  @override
  State<SearchStoresScreen> createState() => _SearchStoresScreenState();
}

class _SearchStoresScreenState extends State<SearchStoresScreen> {
  final _searchField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: AppBar().preferredSize.height,
          child: TextField(
            controller: _searchField,
            autofocus: true,
            onChanged: Provider.of<SearchStoreProvider>(context, listen: false)
                .getStores,
            decoration: InputDecoration(
                suffix: const Icon(Icons.search),
                prefix: IconButton(
                  onPressed: () => _searchField.clear(),
                  icon: const Icon(Icons.cancel_outlined),
                ),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: MyTheme.primary)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: MyTheme.primary))),
          ),
        ),
      ),
      body: Consumer<SearchStoreProvider>(
        builder: (_, provider, widget) {
          if (provider.searchState == SearchState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.stores.isEmpty) {
            return const Text("no results found");
          }
          if (provider.searchState == SearchState.hasData ||
              provider.stores.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: DeviceSize.myWidth(10)),
              itemBuilder: (_, i) => StoreCard(
                provider.stores[i],
                large: true,
              ),
              itemCount: provider.stores.length,
            );
          }
          return const Text("error");
        },
      ),
    );
  }
}
