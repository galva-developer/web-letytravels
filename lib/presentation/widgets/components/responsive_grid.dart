import 'package:flutter/material.dart';
import 'package:by_lety_travels/utils/responsive_utils.dart';

/// Responsive Grid Widget that adapts columns based on screen size
/// Mobile: 1 column, Tablet: 2 columns, Desktop: 3 columns
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final EdgeInsets? padding;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16,
    this.runSpacing = 16,
    this.padding,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = ResponsiveUtils.getScreenWidth(context);
    int columns;

    // Determine number of columns based on screen size
    if (screenWidth < ResponsiveUtils.mobile) {
      columns = mobileColumns ?? 1;
    } else if (screenWidth < ResponsiveUtils.desktop) {
      columns = tabletColumns ?? 2;
    } else {
      columns = desktopColumns ?? 3;
    }

    return Padding(
      padding: padding ?? ResponsiveUtils.getResponsivePadding(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth =
              (constraints.maxWidth - (spacing * (columns - 1))) / columns;

          return Wrap(
            spacing: spacing,
            runSpacing: runSpacing,
            children:
                children.map((child) {
                  return SizedBox(width: itemWidth, child: child);
                }).toList(),
          );
        },
      ),
    );
  }
}

/// Responsive Grid View with better performance for large lists
class ResponsiveGridView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double spacing;
  final double runSpacing;
  final EdgeInsets? padding;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const ResponsiveGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.spacing = 16,
    this.runSpacing = 16,
    this.padding,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        int columns;

        // Determine number of columns based on screen size
        if (screenWidth < ResponsiveUtils.mobile) {
          columns = mobileColumns ?? 1;
        } else if (screenWidth < ResponsiveUtils.desktop) {
          columns = tabletColumns ?? 2;
        } else {
          columns = desktopColumns ?? 3;
        }

        return GridView.builder(
          padding: padding ?? ResponsiveUtils.getResponsivePadding(context),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: runSpacing,
            childAspectRatio: _getChildAspectRatio(context),
          ),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          physics: physics,
          shrinkWrap: shrinkWrap,
        );
      },
    );
  }

  double _getChildAspectRatio(BuildContext context) {
    // Adjust aspect ratio based on screen size for better card proportions
    if (ResponsiveUtils.isMobile(context)) {
      return 0.75; // Taller cards on mobile
    } else if (ResponsiveUtils.isTablet(context)) {
      return 0.8;
    } else {
      return 0.85; // Slightly wider cards on desktop
    }
  }
}

/// Responsive Masonry Grid for variable height items
class ResponsiveMasonryGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final EdgeInsets? padding;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;

  const ResponsiveMasonryGrid({
    super.key,
    required this.children,
    this.spacing = 16,
    this.padding,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = ResponsiveUtils.getScreenWidth(context);
    int columns;

    if (screenWidth < ResponsiveUtils.mobile) {
      columns = mobileColumns ?? 1;
    } else if (screenWidth < ResponsiveUtils.desktop) {
      columns = tabletColumns ?? 2;
    } else {
      columns = desktopColumns ?? 3;
    }

    return Padding(
      padding: padding ?? ResponsiveUtils.getResponsivePadding(context),
      child: _buildMasonryLayout(columns),
    );
  }

  Widget _buildMasonryLayout(int columns) {
    if (columns == 1) {
      return Column(
        children:
            children
                .map(
                  (child) => Padding(
                    padding: EdgeInsets.only(bottom: spacing),
                    child: child,
                  ),
                )
                .toList(),
      );
    }

    // Distribute items across columns
    List<List<Widget>> columnChildren = List.generate(columns, (_) => []);

    for (int i = 0; i < children.length; i++) {
      columnChildren[i % columns].add(
        Padding(padding: EdgeInsets.only(bottom: spacing), child: children[i]),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        columns,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index > 0 ? spacing / 2 : 0,
              right: index < columns - 1 ? spacing / 2 : 0,
            ),
            child: Column(children: columnChildren[index]),
          ),
        ),
      ),
    );
  }
}
