import 'dart:developer';
import 'package:graphql/client.dart';
import 'package:musikon_2022/utils/repository.dart';
import '../objects.dart';

class SongRepository {
  static GraphQLClient client, adminClient;

  initClient() async {
    try {
      final _httpLink = HttpLink('${Repository.url}/graphql', defaultHeaders: {
        "Authorization": "Bearer ${Repository.accessToken}"
      });

      final _adminHttpLink = HttpLink('${Repository.url}/graphql/system',
          defaultHeaders: {
            "Authorization": "Bearer ${Repository.accessToken}"
          });

      adminClient = GraphQLClient(
        link: _adminHttpLink,
        cache: GraphQLCache(),
      );

      client = GraphQLClient(
        cache: GraphQLCache(),
        link: _httpLink,
      );

      log("SongRepository.initClient ${client.hashCode}");

      return true;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<QueryResult> runQuery(String query) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
      variables: const <String, dynamic>{},
    );
    final QueryResult result = await client.query(options);
    return result;
  }

  Future<QueryResult> runQueryAdmin(String query) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
      variables: const <String, dynamic>{},
    );
    final QueryResult result = await adminClient.query(options);
    return result;
  }

  Future<List<Collection>> getCollectionsForDashboard() async {
    try {
      String query = """
        {
          Collections(filter: { show_on_dashboard: { _eq: true } }) {
            id
            title
            subtitle
            display
            songs {
              Songs_id {
                id
                name
                genre {
                  name
                }
                explicit
                enabled
                song_file {
                  id
                }
                album {
                  cover {
                    id
                  }
                }
                user_created {
                  id
                  first_name
                  last_name
                }
              }
            }
          }
        }
    """;

      QueryResult result = await runQuery(query);

      List<Collection> objects = [];

      for (var collection in result.data["Collections"]) {
        objects.add(Collection.fromJson(collection));
      }

      log("SongRepository.getCollections ${result.timestamp}");

      return objects;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<Collection>> getCollectionsForCollection() async {
    try {
      String query = """
        {
          collections(filter: { show_on_dashboard: { _eq: false } }) {
            id
            title
            subtitle
            display
            songs {
              songs_id {
                id
                name
                genre {
                  name
                }
                explicit
                enabled
                song_file {
                  id
                }
                album {
                  cover {
                    id
                  }
                }
                user_created {
                  id
                  first_name
                  last_name
                }
              }
            }
          }
        }
    """;

      QueryResult result = await runQuery(query);

      List<Collection> objects = [];

      for (var collection in result.data["collections"]) {
        objects.add(Collection.fromJson(collection));
      }

      log("SongRepository.getCollections ${result.timestamp}");

      return objects;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<Song>> searchSongs(String text) async {
    try {
      String query = """
        {
          Songs(search: "$text") {
            id
            name
            genre {
              name
            }
            explicit
            enabled
            song_file {
              id
            }
            album {
              cover {
                id
              }
            }
            user_created {
              id
              first_name
              last_name
            }
          }
        }
    """;

      QueryResult result = await runQuery(query);

      List<Song> objects = [];

      for (var collection in result.data["Songs"]) {
        objects.add(Song.fromJson(collection));
      }

      log("SongRepository.searchSongs ${result.timestamp}");

      return objects;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<Collection> recentlyPlayed() async {
    try {
      String query = """
        query {
          users_me {
            recently_played {
              songs_id {
                id
                name
                genre {
                  name
                }
                explicit
                enabled
                song_file {
                  id
                }
                album {
                  cover {
                    id
                  }
                }
                user_created {
                  id
                  first_name
                  last_name
                }
              }
            }
          }
        }

    """;

      QueryResult result = await runQueryAdmin(query);

      var object = result.data["users_me"]["recently_played"];

      object = {"songs": object};

      log("SongRepository.recentlyPlayed ${result.timestamp}");

      return Collection.fromJson(object);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<Collection> favourites() async {
    try {
      String query = """
          query {
            users_me {
              favourites {
                songs_id {
                  id
                  name
                  genre {
                    name
                  }
                  explicit
                  enabled
                  song_file {
                    id
                  }
                  album {
                    cover {
                      id
                    }
                  }
                  user_created {
                    id
                    first_name
                    last_name
                  }
                }
              }
            }
          }
    """;

      QueryResult result = await runQueryAdmin(query);

      var object = result.data["users_me"]["favourites"];

      object = {"songs": object};

      log("SongRepository.favourites ${result.timestamp}");

      return Collection.fromJson(object);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<String> addToFavourites(String userId,String songId) async {
    try {
      String query = """
          mutation {
            create_junction_directus_users_songs_item(
              data: {
                directus_users_id: {
                  id: "$userId"
                  status: "active"
                  provider: "default"
                }
                songs_id: { id: "$songId" }
              }
            ) {
              id
            }
          }
    """;

      QueryResult result = await runQueryAdmin(query);

      log("SongRepository.addToFavourites ${result.timestamp}");

      return result.data["create_junction_directus_users_songs_item"]["id"];
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<String> getUserId() async {
    try {
      String query = """
            query {
              users_me {
                id
              }
            }
    """;

      QueryResult result = await runQueryAdmin(query);

      var object = result.data["users_me"]["id"];

      log("SongRepository.getUserId ${result.timestamp}");

      return object;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
