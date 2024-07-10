import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtrack/bloc/adminhomebloc/adminhome_bloc.dart';
import 'package:foodtrack/bloc/authbloc/auth_bloc.dart';
import 'package:foodtrack/constants/colors.dart';
import 'package:foodtrack/ui/widgets/customtextfeild.dart';
import '../widgets/customtile.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routename = 'adminhome';
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final adminhomebloc = AdminhomeBloc();
  String dvalue = "Breakfast";

  // @override
  // void initState() {
  //   adminhomebloc.add(GetUsersEvent());
  //   super.initState();
  // }
  @override
  void didChangeDependencies() {
    adminhomebloc.add(GetUsersEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: adminhomebloc,
      child: BlocConsumer<AdminhomeBloc, AdminhomeState>(
        listenWhen: (previous, current) => current is AdminHomeActionState,
        buildWhen: (previous, current) => current is !AdminHomeActionState,
        listener: (context, state) {
          
          if (state is AdminHomeErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errmsg)));
          }
          if (state is FoodAddedState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Food added successfully!')));
            adminhomebloc.add(GetUsersEvent());
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                showAlert(context);
              },
              label: const Text("Add Food"),
            ),
            appBar: AppBar(
              title: const Text("Admin Panel"),
              backgroundColor: primary,
            ),
            body: state is AdminHomeLoadingState
                ? const Center(
                    child: const CircularProgressIndicator(),
                  )
                : state is UsersLoadedState
                    ? state.users.isEmpty
                        ? const Center(
                            child: Text("No users found"),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 8),
                            itemCount: state.users.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              return CustomTile(
                                title: state.users[index].name,
                                subtitle: "pending",
                                img:
                                    "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg",
                              );
                            },
                          )
                    : const Center(
                        child: Text("Whoops Something went wrong"),
                      ),
          );
        },
      ),
    );
  }

  Future<dynamic> showAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: bgcolor,
            title: Text("Enter food details",
                style: Theme.of(context).textTheme.titleMedium),
            content: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFeild(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      hint: "Name",
                      type: FeildType.normal,
                      ctrlr: nameController),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFeild(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                      hint: "Price",
                      type: FeildType.normal,
                      ctrlr: priceController),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFeild(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an image link';
                        }
                        return null;
                      },
                      hint: "Image link",
                      type: FeildType.normal,
                      ctrlr: linkController),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 25),
                    decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height / 40),
                    ),
                    child: Row(
                      children: [
                        const Text("Type:"),
                        const Spacer(),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: bgcolor,
                            elevation: 0,
                            value: dvalue,
                            items: const [
                              DropdownMenuItem(
                                value: "Breakfast",
                                child: Text("Breakfast"),
                              ),
                              DropdownMenuItem(
                                value: "Lunch",
                                child: Text("Lunch"),
                              ),
                              DropdownMenuItem(
                                value: "Snacks",
                                child: Text("Snacks"),
                              ),
                              DropdownMenuItem(
                                value: "Beverage",
                                child: Text("Beverage"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                dvalue = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          adminhomebloc.add(AddFoodRequestEvent(
                              imagelink: linkController.text.trim(),
                              name: nameController.text.trim(),
                              price: double.parse(
                                priceController.text.trim(),
                              ),
                              type: dvalue));
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Add food"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
