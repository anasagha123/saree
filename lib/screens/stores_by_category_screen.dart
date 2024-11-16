import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saree/providers/stores_by_category_provider.dart';
import 'package:saree/widgets/components/store_card.dart';

import '../config/theme.dart';

class StoresByCategoryScreen extends StatefulWidget {
  static const routeName = "/store-by-category";

  const StoresByCategoryScreen({super.key});

  @override
  State<StoresByCategoryScreen> createState() => _StoresByCategoryScreenState();
}

class _StoresByCategoryScreenState extends State<StoresByCategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StoresByCategoryProvider>(context, listen: false).getStores();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Provider.of<StoresByCategoryProvider>(context, listen: false)
                .category
                .name),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body:  const DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            indicatorColor: MyTheme.primary,
            labelColor: MyTheme.primary,
            tabs: [
              Tab(text: "خصومات"),
              Tab(text: "توصيل مجاني"),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 16),
            child: TabBarView(
              children: [
                RestaurantsList(),
                RestaurantsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RestaurantsList extends StatelessWidget {
  const RestaurantsList({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<StoresByCategoryProvider>(context, listen: false)
            .getStores();
      },
      child: Consumer<StoresByCategoryProvider>(
        builder: (context, provider, child) {
          if (provider.storesBuCategoryState == StoresByCategoryState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.storesBuCategoryState == StoresByCategoryState.hasData &&
              provider.stores.isNotEmpty) {
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemBuilder: (_, i) => StoreCard(
                    provider.stores[i],
                    large: true,
                  ),
                  itemCount: provider.stores.length,
                ),
              ],
            );
          }
          if (provider.storesBuCategoryState == StoresByCategoryState.hasData &&
              provider.stores.isEmpty) {
            return const CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(
                    child: Text("empty"),
                  ),
                )
              ],
            );
          }
          return const CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Center(child: Text("network error")),
              ),
            ],
          );
        },
      ),
    );
  }
}
