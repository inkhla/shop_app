import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

// ignore: must_be_immutable
class ShopSearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: searchController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter text to search';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        onSubmit: (String text) {
                          SearchCubit.get(context).getSearchData(text: text);
                        },
                      ),
                      SizedBox(height: 10),
                      state is SearchLoadingState
                          ? LinearProgressIndicator()
                          : SizedBox.shrink(),
                      SizedBox(height: 10),
                      state is SearchSuccessState
                          ? Expanded(
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    myDivider(),
                                itemCount: SearchCubit.get(context).searchModel!.data!.data.length,
                                itemBuilder: (context, index) =>
                                    buildListProducts(SearchCubit.get(context).searchModel!.data!.data[index], context, isOldPrice: false),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
