import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uzum_market/src/features/home/cubit/home_cubit.dart';
import 'package:uzum_market/src/features/home/cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  bool isbuttom = false;
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isbuttom = true;
        setState(() {});
      } else {
        isbuttom = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/like');
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is HomeErrorState) {
            return Center(child: Text(state.message));
          } else if (state is HomeSuccesState) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 140),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 32,
                        mainAxisExtent: 456,
                        crossAxisCount: 5,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 210,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  state.products[index].image,
                                  height: 309,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(state.products[index].name),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Visibility(
                      visible: isbuttom,
                      child: CupertinoButton.filled(
                        child: Text('Yana ko\'rsatish 5 ta'),
                        onPressed: () {
                          context.read<HomeCubit>().loadProducts(
                            limit: 5,
                            currentState: HomeSuccesState(
                              products: state.products,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: IconButton(onPressed: () {}, icon: Icon(Icons.error)),
            );
          }
        },
      ),
    );
  }
}
