import 'package:evently/core/app_provider/app_provider.dart';
import 'package:evently/modules/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';

class ProfileScreen extends  StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user =FirebaseAuth.instance.currentUser!;
    var provider =Provider.of<AppProvider>(context);
    ThemeData theme=Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 26,),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage:AssetImage("assets/images/logo/route.png"),
              ),
            ),
            SizedBox(height: 10,),
            Text(user.displayName??"",style: theme.textTheme.titleLarge),
            SizedBox(height: 4,),
            Text(user.email??"",style: TextStyle(
              color: theme==ThemeMode.dark? AppColors.darkTextColor: AppColors.lightGreyColor,
              fontSize: 14

            )),
            SizedBox(height: 32,),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color:theme.primaryColorLight,
                border: Border.all(
                  color:theme.dividerColor,
                ),
                borderRadius: BorderRadius.circular(16),

                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dark mode",style: theme.textTheme.titleLarge,),
                  Transform.scale(
                    scale: .8,
                      child: Switch(
                        activeThumbColor: theme.primaryColor,
                        inactiveThumbColor: AppColors.darkGreyColor,
                          value: provider.themeMode==ThemeMode.dark, onChanged: (value){
                          provider.changeTheme( value? ThemeMode.dark :ThemeMode.light);
                      })),
                ],
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                showModalBottomSheet(context: context,showDragHandle: true ,backgroundColor: theme.scaffoldBackgroundColor,builder: (_){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                     children: [
                       Center(child: Text("Language",style: theme.textTheme.titleLarge,)),
                       SizedBox(height: 20,),
                       GestureDetector(
                         onTap: (){
                           provider.changeLanguage("ar");
                         },
                         child: Container(
                           padding: const EdgeInsets.all(16),
                           decoration: BoxDecoration(
                             color:theme.primaryColorLight,
                             border: Border.all(
                               color:provider.locale=="ar"?theme.primaryColor:theme.primaryColorLight,
                             ),
                             borderRadius: BorderRadius.circular(16),

                             boxShadow: const [
                               BoxShadow(
                                 color: AppColors.shadow,
                               ),
                             ],
                           ),

                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Arabic",style: theme.textTheme.titleLarge,),
                             ],
                           ),
                         ),
                       ),
                       SizedBox(height: 20,),
                       GestureDetector(
                         onTap:(){
                           provider.changeLanguage("en");
                         },
                         child: Container(
                           padding: const EdgeInsets.all(16),
                           decoration: BoxDecoration(
                             color:theme.primaryColorLight,
                             border: Border.all(
                               color:provider.locale=="en"?theme.primaryColor:theme.primaryColorLight,
                             ),
                             borderRadius: BorderRadius.circular(16),

                             boxShadow: const [
                               BoxShadow(
                                 color: AppColors.shadow,
                               ),
                             ],
                           ),

                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("English",style: theme.textTheme.titleLarge,),
                             ],
                           ),
                         ),
                       ),
                     ],
                    ),
                  ) ;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:theme.primaryColorLight,
                  border: Border.all(
                    color:theme.dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Language",style: theme.textTheme.titleLarge,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_forward_ios_rounded,color: theme.primaryColor,),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:theme.primaryColorLight,
                  border: Border.all(
                    color:theme.dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(16),

                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                    ),
                  ],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logout",style: theme.textTheme.titleLarge,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.logout,color: Color(0xFFFF3232),),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
