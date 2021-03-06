import 'package:black_cumin/providers/articles.dart';
import 'package:black_cumin/widgets/articles_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleOverviewScreen extends StatefulWidget {
  static const routeName = '/article-overview-screen';
  final int journalId;
  ArticleOverviewScreen({this.journalId});
  @override
  _ArticleOverviewScreenState createState() => _ArticleOverviewScreenState();
}

class _ArticleOverviewScreenState extends State<ArticleOverviewScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Articles>(context).fetchAndSetArticles(widget.journalId);
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(child: ArticlesList(journalId: widget.journalId)),
    );
  }
}
