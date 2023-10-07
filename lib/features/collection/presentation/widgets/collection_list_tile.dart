import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/images/raster_images.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';
import 'package:transparent_image/transparent_image.dart';

class CollectionListTile extends StatelessWidget {
  const CollectionListTile({required this.collection, super.key});

  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: context.colorScheme.secondary.withOpacity(0.15),
      onTap: () {
        context.push('${Routes.collection}/${collection.id}', extra: collection);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.primaryContainer.withOpacity(0.2).darken(),
              context.colorScheme.primaryContainer.withOpacity(0.2)
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: collection.imageUrl == null
                  ? Image.asset(
                      RasterImages.defaultCover,
                      height: 120,
                      width: 80,
                      fit: BoxFit.cover,
                    )
                  : Stack(
                      children: [
                        const Positioned.fill(
                          child: Center(
                            child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                          ),
                        ),
                        FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: collection.imageUrl!,
                          height: 120,
                          width: 80,
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeInOut,
                        ),
                      ],
                    ),
            ),
            Spacers.m,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.title,
                    style: context.textTheme.titleMedium,
                  ),
                  Spacers.xs,
                  Text(
                    collection.quotesQuantity > 0 ? '${collection.quotesQuantity} quotes' : 'No quotes yet',
                    style: context.textTheme.labelSmall,
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                    color: context.colorScheme.primaryContainer,
                    endIndent: 40,
                  ),
                  if (collection.description != null)
                    Text(
                      collection.description!,
                      style: context.textTheme.bodyMedium,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
