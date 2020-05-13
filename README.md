# app

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```dart
///网络配置的URL
final String baseUrl = "http://192.168.0.103:8080";
```

   页码上拉滑动加载
```dart
  ///上拉
  Future _onRefresh() async {
    print("_onRefresh...");
    await Future.delayed(Duration(seconds: 2), () {
      if (_pageNum - 1 <= 0) {
        Toast.show("已经到达顶部,没有数据了！", context);
        return;
      }
      if (_pageNum > 0 &&
          _pageNum <= _totalPage &&
          _currentPage >= 1 &&
          _currentPage <= _totalPage) {
        //load
        _pageNum -= 1;
        _currentPage -= 1;
        getPageData();
        setState(() {});
      }
    });
  }
```

  页码下拉滑动加载
```dart
  ///下拉
  Future _onLoad() async {
    print("_onLoad...");
    await Future.delayed(Duration(seconds: 2), () {
      if (_pageNum >= _totalPage) {
        Toast.show("已经到达尾部,没有数据了！", context);
        return;
      }
      if (_pageNum > 0 &&
          _pageNum <= _totalPage &&
          _currentPage >= 1 &&
          _currentPage <= _totalPage) {
        //load
        _pageNum += 1;
        _currentPage += 1;
        getPageData();
      }
      setState(() {});
    });
  }
```