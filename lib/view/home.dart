import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_api_app/BusinssLogic/HomePageBloc/home_bloc.dart';
import 'package:simple_api_app/view/add_note.dart';

class HomePage extends StatefulWidget {
  final String mytoken;
  const HomePage({super.key, required this.mytoken});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  late String userId;

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    initPrefs();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.mytoken);
    userId = jwtDecodedToken['_id'];
    homeBloc.add(HomeInitialGetNotesEvent(userId: userId));
    super.initState();
  }

  logOut() {
    Navigator.of(context).pushReplacementNamed('/landingPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await prefs.remove('token');
                logOut();
              },
              icon: const Icon(Icons.login_rounded))
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (current, previous) => current is HomeActionState,
        buildWhen: (current, previous) => current is !HomeActionState,
        listener: (context, state) {
          // switch (state.runtimeType) {
          //   case HomeNavigateToAddNotePage:
             
          //     break;
          //   default:
          // }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return const Center(child: CircularProgressIndicator());
            case HomeFetchingSuccessState:
              final successState = state as HomeFetchingSuccessState;
              return ListView.builder(
                itemCount: successState.notesList.length,
                itemBuilder: (context, index) {
                  var note = successState.notesList[index];
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      title: Text(note.title ?? ""),
                      subtitle: Text(note.description ?? ""),
                    ),
                  );
                },
              );

            default:
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddNotePage(
                        userId: userId,
                        bloc: homeBloc,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
