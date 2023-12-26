import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<ItemType> = Widget Function(
  BuildContext context,
  ItemType item,
  int index,
);

class _Const {
  static const pageSize = 10;
}

class InfiniteList<ItemType> extends StatefulWidget {
  const InfiniteList({
    Key? key,
    required this.getData,
    this.pageSize = _Const.pageSize,
    this.shrinkWrap = false,
    required this.itemBuilder,
    this.circularProgressIndicator = const CircularProgressIndicator(),
    this.noItemFoundWidget,
    required this.scrollController,
    required this.infiniteListController,
    this.heightGap,
    this.animate = false,
    this.itemPerLine = 1,
  }) : super(key: key);

  final Future<List<ItemType>> Function(int) getData;
  final int pageSize;
  final bool shrinkWrap;
  final ItemWidgetBuilder<ItemType> itemBuilder;
  final Widget circularProgressIndicator;
  final Widget? noItemFoundWidget;
  final ScrollController scrollController;
  final InfiniteListController<ItemType> infiniteListController;
  final double? heightGap;
  final bool animate;
  final int itemPerLine;

  @override
  State<InfiniteList<ItemType>> createState() => _InfiniteListState<ItemType>();
}

class _InfiniteListState<ItemType> extends State<InfiniteList<ItemType>> {
  @override
  void initState() {
    widget.infiniteListController
        .onLoadMore(getData: widget.getData, pageSize: widget.pageSize);
    widget.scrollController.addListener(() {
      if (widget.scrollController.offset >=
              widget.scrollController.position.maxScrollExtent &&
          !widget.scrollController.position.outOfRange) {
        widget.infiniteListController.onLoadMore(
          getData: widget.getData,
          pageSize: widget.pageSize,
        );
      }
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   widget.scrollController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return ValueListenableBuilder<PagingState<ItemType>>(
      valueListenable: widget.infiniteListController,
      builder: (context, pagingState, child) {
        if (pagingState.isRefresh) {
          widget.infiniteListController.onLoadMore(
            getData: widget.getData,
            pageSize: widget.pageSize,
          );
        }
        return widget.itemPerLine > 1
            ? ListView.separated(
                shrinkWrap: widget.shrinkWrap,
                controller: !widget.shrinkWrap ? widget.scrollController : null,
                itemCount: (pagingState.listItem.length / 2).ceil() + 1,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (pagingState.listItem.isEmpty && !pagingState.isLoading) {
                    return widget.noItemFoundWidget ?? const Text("no data");
                  } else {
                    return GridView.count(
                      shrinkWrap: widget.shrinkWrap,
                      crossAxisCount: widget.itemPerLine, // Two items per row
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: (itemWidth / itemHeight) + 0.05,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        widget.itemPerLine, // Number of items per row
                        (i) {
                          final itemIndex = index * widget.itemPerLine + i;
                          if (itemIndex < pagingState.listItem.length) {
                            return (widget.itemBuilder)(
                              context,
                              pagingState.listItem[itemIndex],
                              itemIndex,
                            );
                          } else if (pagingState.hasMore) {
                            return Center(
                                child: widget.circularProgressIndicator);
                          }
                          return pagingState.isLoading
                              ? Center(child: widget.circularProgressIndicator)
                              : const SizedBox.shrink();
                        },
                      ),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: widget.heightGap ?? 16);
                },
              )
            : ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: widget.shrinkWrap,
                controller: !widget.shrinkWrap ? widget.scrollController : null,
                itemBuilder: (context, index) {
                  if (pagingState.listItem.isEmpty && !pagingState.isLoading) {
                    return widget.noItemFoundWidget ?? const Text("no data");
                  } else if (index < pagingState.listItem.length) {
                    return (widget.itemBuilder)(
                      context,
                      pagingState.listItem[index],
                      index,
                    );
                  } else if (pagingState.hasMore) {
                    return Center(child: widget.circularProgressIndicator);
                  }
                  return pagingState.isLoading
                      ? Center(child: widget.circularProgressIndicator)
                      : const SizedBox.shrink();
                },
                itemCount: pagingState.listItem.length + 1,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: widget.heightGap ?? 16);
                },
              );
      },
    );
  }
}

class InfiniteListController<ItemType>
    extends ValueNotifier<PagingState<ItemType>> {
  InfiniteListController() : super(PagingState<ItemType>());

  factory InfiniteListController.init() {
    return InfiniteListController<ItemType>();
  }

  List<ItemType>? get itemList => value.listItem;

  set itemList(List<ItemType>? newItemList) {
    value = PagingState<ItemType>(
        listItem: newItemList ?? [],
        hasMore: false,
        isRefresh: false,
        isLoading: false);
    notifyListeners();
  }

  void onRefresh() {
    value = value.copyWith(
      pages: 0,
      isLoading: true,
      hasMore: true,
      isRefresh: true,
      listItem: [],
    );
    notifyListeners();
  }

  void onLoadMore({
    required Future<List<ItemType>> Function(int) getData,
    int pageSize = _Const.pageSize,
  }) async {
    value = value.copyWith(isLoading: true);
    int page = value.pages;
    if (!value.hasMore) {
      value = value.copyWith(isLoading: false);
      return;
    }
    final response = await getData(value.pages);
    if (response.isNotEmpty) {
      value = value.copyWith(isLoading: false);
      if (response.length < pageSize) {
        value = value.copyWith(hasMore: false);
      } else {
        page++;
        value = value.copyWith(hasMore: true);
      }
      value = value.copyWith(listItem: [...value.listItem, ...response]);
      value = value.copyWith(pages: page, isRefresh: false);
    } else {
      value =
          value.copyWith(hasMore: false, isRefresh: false, isLoading: false);
    }
  }
}

class PagingState<ItemType> {
  final bool hasMore;
  final int pages;
  final bool isLoading;
  final List<ItemType> listItem;
  final bool isRefresh;

  PagingState({
    this.hasMore = true,
    this.pages = 0,
    this.isLoading = false,
    this.isRefresh = false,
    this.listItem = const [],
  });

  PagingState<ItemType> copyWith({
    bool? hasMore,
    int? pages,
    bool? isLoading,
    bool? isRefresh,
    List<ItemType>? listItem,
  }) {
    return PagingState<ItemType>(
      hasMore: hasMore ?? this.hasMore,
      pages: pages ?? this.pages,
      isLoading: isLoading ?? this.isLoading,
      isRefresh: isRefresh ?? this.isRefresh,
      listItem: listItem ?? this.listItem,
    );
  }
}
