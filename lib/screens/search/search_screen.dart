import 'package:flutter_chat_app_demo/app_settings/settings.dart';
import 'package:flutter_chat_app_demo/models/models.dart';
import 'package:flutter_chat_app_demo/screens/search/search_screen_view_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchScreenViewModel>(
      create: (_) => SearchScreenViewModel(),
      child: Consumer<SearchScreenViewModel>(
          builder: (context, vm, _) => CustomScrollView(
                slivers: [
                  const SliverAppBar(
                    pinned: true,
                    title: Text(
                      AppStrings.search,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 16.0,
                            ),
                            child: TextField(
                              controller: vm.searchController,
                              decoration: InputDecoration(
                                hintText: "Type username ...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        )
                      ])
                    ],
                  )),
                ],
              )),
    );
  }
}
