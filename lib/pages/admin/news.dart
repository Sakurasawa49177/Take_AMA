import 'package:flutter/material.dart';
import 'package:take_ama/models/News.dart';

import '../../services/NewsAPI.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: FutureBuilder(
          future: NewsAPI.getAll(),
          builder: (BuildContext context, AsyncSnapshot<List<News?>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('No data'),
              );
            }
            List<News?> newss = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.black,
              ),
              itemCount: newss.length,
              itemBuilder: (BuildContext context, int i) {
                News news = newss[i]!;
                return ListTile(
                  leading: Text(news.title!),
                  title: Text(news.description!),
                  onTap: () {
                    Navigator.pushNamed(context, '/edit-news', arguments: news)
                        .then((value) => setState(() {}));
                  },
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-news')
              .then((value) => setState(() {}));
        },
      ),
    );
  }
}
