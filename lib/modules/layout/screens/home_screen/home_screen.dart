import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_provider/app_provider.dart';
import 'package:evently/core/constants/app_category.dart';
import 'package:evently/core/models/event_model.dart';
import 'package:evently/core/services/db_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/layout/screens/home_screen/widgets/category_container.dart';
import 'package:evently/modules/layout/screens/home_screen/widgets/tab_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName="home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex=0;

  String _categoryName(AppLocalizations l, AppCategory c) {
    switch (c.id) {
      case "sport": return l.catSport;
      case "meeting": return l.catMeeting;
      case "exhibition": return l.catExhibition;
      case "birthday": return l.catBirthday;
      default: return c.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme=Theme.of(context);
    var provider=Provider.of<AppProvider>(context);
    final l = AppLocalizations.of(context)!;
    User user=FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.welcomeBack,style: theme.textTheme.bodySmall,),
                      SizedBox(height: 4,),
                      Text(user.displayName??"",style: theme.textTheme.titleLarge,),
                    ],
                  ),
                ),
                Image.asset(provider.themeMode==ThemeMode.dark?"assets/images/theme/moon2.png":"assets/images/theme/sun.png",color: AppColors.lightPrimaryColor,width: 24,),
                SizedBox(width: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                  decoration: BoxDecoration(
                      color: AppColors.lightPrimaryColor,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text(provider.locale.toUpperCase(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                )

              ],
            ),
            DefaultTabController(
              length: AppCategory.categories.length+1,
              child: TabBar(
                onTap: (index){
                  currentIndex=index;
                  setState(() {

                  });
                },
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.all(0),
                labelPadding: EdgeInsets.all(8),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  TabWidget(isSelected: currentIndex==0, category: AppCategory(image: "", name: l.all, id: "all", iconData: Icons.window_outlined)),
                  ...AppCategory.categories.map((e){
                    int categoryIndex=AppCategory.categories.indexOf(e)+1;
                    return TabWidget(
                      isSelected: currentIndex==categoryIndex,
                      category: AppCategory(
                        image: e.image,
                        name: _categoryName(l, e),
                        id: e.id,
                        iconData: e.iconData,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<EventModel>>(
                stream:DbService().getEventsStream() ,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    debugPrint("Stream error: ${snapshot.error}");
                    return Center(child: Text(snapshot.error.toString(), style: theme.textTheme.titleLarge));
                  }

                  final events = snapshot.data ?? [];

                  final filteredEvents = currentIndex == 0
                      ? events
                      : events
                      .where((e) => e.categoryId == AppCategory.categories[currentIndex - 1].id)
                      .toList();

                  if (filteredEvents.isEmpty) {
                    return Center(child: Text(l.noEventsYet));
                  }

                  return ListView.separated(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) => CategoryContainer(event: filteredEvents[index]),
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}