import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/core/images/svg_images.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/collection/presentation/widgets/collection_list_tile.dart';
import 'package:the_quote/features/home/presentation/page/cubit/home_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/common/header_with_button_and_divider.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: DefaultPagePadding(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Welcome back',
                          style: context.textTheme.headlineLarge?.copyWith(
                            fontFamily: Fonts.sourceSerifPro,
                          ),
                        ),
                      ),
                      Spacers.l,
                      SvgPicture.asset(
                        SvgImages.quotes,
                        colorFilter: ColorFilter.mode(
                          context.colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                        height: 40,
                      ),
                    ],
                  ),
                  Spacers.xs,
                  Text(
                    'There is 323 quotes in your vault!',
                    style: context.textTheme.bodyMedium,
                  ),
                  Spacers.xxl,
                  HeaderWithButtonAndDivider(
                    title: 'Kolekcje',
                    onPressed: () => context.push(Routes.addOrEditCollection),
                    icon: Icons.add,
                  ),
                  state.maybeWhen(
                    orElse: CircularProgressIndicator.adaptive,
                    loaded: (collections) {
                      return Column(
                        children: collections
                            .map(
                              (c) => Column(
                                children: [
                                  CollectionListTile(collection: c),
                                  Spacers.l,
                                ],
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
