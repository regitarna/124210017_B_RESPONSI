import 'package:flutter/material.dart';
import 'package:responsi_regita/load_data/api_source.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<Map<String, dynamic>>? _data;

  @override
  void initState() {
    super.initState();
    _data = ApiDataSource.instance.loadDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!['meals'][0];
          return Scaffold(
            appBar: AppBar(
                title: Text(
                  data['strMeal'],
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.brown[300]),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                      width: 100,
                      height: 132,
                      decoration: BoxDecoration(
                        border: Border.all( //<-- SEE HERE
                          width: 3,
                          color: Colors.black87,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.brown.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(data['strMealThumb'], width: 200, height: 200),
                      )
                  ),

                  SizedBox(height: 10),
                  Text(
                    data['strMeal'],
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Category : " + data['strCategory']),
                      SizedBox(width: 75),
                      Text("Area : " + data['strArea']),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Ingredients
                  Text(
                    "Ingredients",
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 18,
                    itemBuilder: (context, index) {
                      if (data['strIngredient' + (index + 1).toString()] !=
                          "") {
                        return Row(
                          children: [
                            Text(
                              data['strIngredient' + (index + 1).toString()] +
                                  " : ",
                              style: const TextStyle(fontSize: 13),
                            ),
                            Text(
                              data['strMeasure' + (index + 1).toString()],
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  // Instructions
                  Text(
                    "Instructions",
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    data['strInstructions'],
                    style: const TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 10),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown[300],
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      //  Launch URL
                      _launchUrl(data['strYoutube']);
                    },
                    child: const Text('Watch Tutorial'),
                  ),

                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  Future<void> _launchUrl(String link) async {
    final Uri uri = Uri.parse(link);
    if (!await launchUrl(uri)) {
      throw Exception("gagal buka link : $uri");
    }
  }
}