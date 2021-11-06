
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';


class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).favoritesModel!.data!.data;
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.length,
            itemBuilder: (context, index) => buildListProducts(cubit[index].product, context),
          ),

        );
      },
    );
  }
}

