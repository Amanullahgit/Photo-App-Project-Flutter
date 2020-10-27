import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

class DetailScreen extends StatefulWidget {
  final String url;
  DetailScreen(this.url);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _progress = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
            child: Center(
              child: Hero(
                tag: 'imageHero',
                child: Image.network(widget.url),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.lightBlue,
                  valueColor: new AlwaysStoppedAnimation(Colors.red),
                  value: _progress.toDouble() / 100,
                ),
              ),
              Container(
                child: IconButton(
                  iconSize: 42,
                  color: Colors.lightBlue,
                  icon: Icon(Icons.file_download),
                  onPressed: () async {
                    await ImageDownloader.downloadImage(widget.url,
                        destination: AndroidDestinationType.custom(
                            directory: 'Pictures'));
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
