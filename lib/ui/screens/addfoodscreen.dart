import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/bloc/addfoodbloc/addfood_bloc.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/models/foodmodel.dart';
import 'package:foodtrack/ui/screens/homescreen.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';
import 'package:foodtrack/ui/widgets/incrementer.dart';
import 'package:logger/logger.dart';

import '../widgets/filterpick.dart';
import '../widgets/foodtile.dart';

class AddFoodScreen extends StatefulWidget {
  static const routename = 'addfood';
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  List<Food> addedFood = [];

  final addfoodbloc = AddfoodBloc();
  @override
  void initState() {
    addfoodbloc.add(GetFoodItemsEvent(type: null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: addfoodbloc,
      child: BlocConsumer<AddfoodBloc, AddfoodState>(
        listener: (context, state) {
          if (state is FoodErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errmsg)));
          }
          if (state is FoodAddedState) {
           Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
          }
        },
        builder: (context, state) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(onPressed: () {
                log(addedFood.toString());
                log(addedFood.first.qty.toString());
              }),
              appBar: AppBar(
                title: const Text("Add Food"),
                backgroundColor: primary,
                actions: [
                  Text(
                    "₹${addedFood.fold<double>(0, (sum, food) => sum + (food.price * food.qty)).toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {
                        if (addedFood.isNotEmpty) {
                          addfoodbloc.add(AddBillEvent(items: addedFood));
                          
                        }
                      },
                      icon: const Icon(Icons.done))
                ],
                scrolledUnderElevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    width: double.maxFinite,
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        FilterPick(
                          img:
                              "https://static.vecteezy.com/system/resources/previews/019/614/281/non_2x/breakfast-graphic-clipart-design-free-png.png",
                          text: "Breakfast",
                          actionFunction: (selected) {
                            if (selected) {
                              addfoodbloc
                                  .add(GetFoodItemsEvent(type: 'Breakfast'));
                            } else {
                              addfoodbloc.add(GetFoodItemsEvent(type: null));
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FilterPick(
                          img:
                              "https://purepng.com/public/uploads/large/purepng.com-lunch-boxfood-box-school-lunch-box-lunch-941524636030wxs9g.png",
                          text: "Lunch",
                          actionFunction: (selected) {
                            if (selected) {
                              addfoodbloc.add(GetFoodItemsEvent(type: 'Lunch'));
                            } else {
                              addfoodbloc.add(GetFoodItemsEvent(type: null));
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FilterPick(
                          img:
                              "https://i0.wp.com/www.treatwell.co.in/wp-content/uploads/2023/01/pazhampori.png?fit=500%2C500&ssl=1",
                          text: "Snacks",
                          actionFunction: (selected) {
                            if (selected) {
                              addfoodbloc
                                  .add(GetFoodItemsEvent(type: 'Snacks'));
                            } else {
                              addfoodbloc.add(GetFoodItemsEvent(type: null));
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FilterPick(
                          img:
                              "https://static.vecteezy.com/system/resources/previews/025/268/632/non_2x/chicken-makhani-with-ai-generated-free-png.png",
                          text: "Curry",
                          actionFunction: (selected) {
                            if (selected) {
                              addfoodbloc.add(GetFoodItemsEvent(type: 'Curry'));
                            } else {
                              addfoodbloc.add(GetFoodItemsEvent(type: null));
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FilterPick(
                          img:
                              "https://static.vecteezy.com/system/resources/thumbnails/025/230/141/small_2x/fried-fish-carp-and-fresh-lemon-slice-on-transparent-background-free-png.png",
                          text: "Addons",
                          actionFunction: (selected) {
                            if (selected) {
                              addfoodbloc.add(GetFoodItemsEvent(type: 'Addon'));
                            } else {
                              addfoodbloc.add(GetFoodItemsEvent(type: null));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  state is FoodLoadedState
                      ? state.fooditems.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                itemCount: state.fooditems.length,
                                itemBuilder: (context, index) {
                                  return FoodTile(
                                    count:getQuantity(state.fooditems[index].id, addedFood),
                                    name: state.fooditems[index].name,
                                    imglink: state.fooditems[index].imageLink,
                                    price:
                                        state.fooditems[index].price.toString(),
                                    onChange: (value) {
                                      if (value == 0) {
                                        Logger().e("addfood=$addedFood");
                                        addedFood.removeWhere((item) =>
                                            item == state.fooditems[index]);
                                        Logger().e("after remove=$addedFood");
                                      } else {
                                        if (addedFood
                                            .contains(state.fooditems[index])) {
                                          addedFood
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  state.fooditems[index].id)
                                              .qty = value;
                                        } else {
                                          addedFood.add(state.fooditems[index]);
                                           addedFood
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  state.fooditems[index].id)
                                              .qty = value;
                                        }
                                      }
                                      setState(() {});
                                    },
                                  );
                                },
                              ),
                            )
                          : const Expanded(
                              child:
                                  const Center(child: Text("No Items Found")))
                      : const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                ],
              ));
        },
      ),
    );
  }
}

int getQuantity(String id,List<Food>addedFood)
{
  try{
return addedFood.firstWhere((element) => element.id==id).qty;
  }catch(e){
    return 0;
  }
}