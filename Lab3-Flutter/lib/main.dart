import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const PrimaryColor = const Color(0xFF303030);

void main() => runApp(
    MaterialApp(
        title: "Github with GraphQL",
        theme: ThemeData(primaryColor: PrimaryColor),
        debugShowCheckedModeBanner: false,
        home: MyApp()
    )
) ;

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  String personal_access_token = "829d6390c9ca41bf8f8157b8ae4e4ef509038c73";

  @override
  Widget build(BuildContext context){
    //return Container();
    final HttpLink httpLink = HttpLink(
        uri: 'https://api.github.com/graphql',
        headers: {"authorization": "Bearer $personal_access_token"
        }
    );
    ValueNotifier <GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink,
            cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject))
    );
    return GraphQLProvider(client: client, child: MyHomePage(),);
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.repoLicense, this.noOfCommits}) : super(key: key);
  final String title;
  final String repoLicense;
  final int noOfCommits;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //String userName = "";

  var selectedLanguage = 'Python';
  List <String> languageList = [
    'Python',
    'Java',
    'C++',
    'TypeScript',
    'C',
    'Ruby',
    'C#',
    'PHP',
  ];

  void _setSelectedLanguage(String newLang){
    setState(() {
      selectedLanguage = newLang;
    });
  }

  String readRespositories = """
    query ReadRepositories (\$queryString: String!) {
      search(query: \$queryString, type: REPOSITORY, first: 10) {
        nodes {
          ... on Repository {
            id
            name
            url
             owner {
              url
            }
            stargazers {
              totalCount
            }
            forks {
              totalCount
            }
           
            licenseInfo {
              name
            }
            description
            refs(refPrefix: "refs/heads/") {
              totalCount
            }
            object(expression: "master") {
              ... on Commit {
                history {
                  totalCount
                }
              }
            }
          }
        }
      }
      
  }
     """;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Lab 3"),
      ),
      body: Center(
        child:
        Column(
          children: <Widget>[
            Expanded(
              child:
              Query(
                options: QueryOptions(
                  documentNode: gql(readRespositories), // this is the query string you just created
                  variables: {
                    //'nRepositories': 50,
                    'queryString': 'sort:stars-desc language: $selectedLanguage stars:>1000',
                  },
                  pollInterval: 10,
                ),
                // Just like in apollo refetch() could be used to manually trigger a refetch
                // while fetchMore() can be used for pagination purpose
                builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.loading) {
                    return Text('Loading');
                  }

                  // it can be either Map or List
                  //List repositories = result.data['viewer']['repositories']['nodes'];
                  List repositories = result.data['search']['nodes'];

                  return
                    ListView.builder(
                        itemCount: repositories.length,
                        itemBuilder: (context, index) {
                          final repository = repositories[index];
                          String repoTitle = repository['name'];
                          String repoURL = repository['url'];
                          int starAmount = repository['stargazers']['totalCount'];
                          int forkAmount = repository['forks']['totalCount'];
                          String repoDisc = repository['description'];
                          int branchAmount = repository['refs']['totalCount'];

                          int noOfCommits = 0;
                          //I don't know why, men if-satsen behövs för att noOfComments ska funka wtf
                          if(repository['object'] != null){
                            noOfCommits = repository['object']['history']['totalCount'];
                          }

                          String repoLicense = "Unknown license";
                          if(repository['licenseInfo'] != null){
                            repoLicense = repository['licenseInfo']['name'].toString();
                          }

                          return infoBox(
                            title : repoTitle,
                            repositoryURL: repoURL,
                            totalStarAmount : starAmount,
                            totalForkAmount : forkAmount,
                            repoDisc : repoDisc,
                            branchAmount : branchAmount,
                            noOfCommits : noOfCommits,
                            repoLicense : repoLicense,
                          );
                        });
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left:10, right:10),
              decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),


            child: DropdownButton(

              isExpanded: true,
              underline: Container(color: Colors.transparent),
              value: selectedLanguage,
              items: languageList.map<DropdownMenuItem<String>>((String _monthValue) {
                return DropdownMenuItem<String>(
                value: _monthValue,
                child: Text(_monthValue),
              );
             }).toList(),
             onChanged: (value) { _setSelectedLanguage(value);
            //fetchMore(opts);

            },
            ),

            ),
          ],
        ),

      ),

    );
  }
}



