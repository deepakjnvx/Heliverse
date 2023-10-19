import 'package:flutter/material.dart';
import 'package:flutter_heliverse/data.dart';
import 'package:flutter_heliverse/filter_widget.dart';
import 'package:flutter_heliverse/show_team.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int noE;
  bool isLoading = false;
  List<Map<String, dynamic>> _filteredUser = [];
  List<Map<String, dynamic>> teamUser = [];
  final scrollController = ScrollController();
  @override
  void initState() {
    _filteredUser = users;
    _filteredUser.length >= 10 ? noE = 10 : _filteredUser.length;
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void addTeam(user) {
    teamUser.add(user);
  }

  void _scrollListener() async {
    await Future.delayed(const Duration(seconds: 2));
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        noE <= _filteredUser.length) {
      setState(() {
        noE + 10 > _filteredUser.length
            ? noE = noE + 10
            : noE = _filteredUser.length;
      });
    }
  }

  void _runFilter(String enterdKeyword) {
    List<Map<String, dynamic>> result = [];
    if (enterdKeyword.isEmpty) {
      result = users;
    } else {
      result = users
          .where((user) => user["first_name"]
              .toLowerCase()
              .contains(enterdKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredUser = result;
    });
  }

  void applyFilters(String gender, bool avail, String department) {
    List<Map<String, dynamic>> result = [];
    result = users
        .where((user) =>
            user["gender"] == gender &&
            user["domain"] == department &&
            user["available"] == avail)
        .toList();
    setState(() {
      _filteredUser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Heliverse"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShowTeam(teamUser),
                  ),
                );
              },
              icon: const Icon(Icons.groups_2_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Search',
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _filteredUser.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: (noE >= 10 &&
                              _filteredUser.length >= 10 &&
                              noE + 1 < _filteredUser.length)
                          ? (noE + 1)
                          : _filteredUser.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < noE) {
                          return Card(
                            key: ValueKey(_filteredUser[index]["id"]),
                            color: Theme.of(context).colorScheme.inversePrimary,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Colors.blue,
                                  child: CircleAvatar(
                                    radius: 40,
                                    child: Image.network(
                                        _filteredUser[index]["avatar"]),
                                  )),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                        "${_filteredUser[index]["first_name"]} ${_filteredUser[index]["last_name"]}"),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("${_filteredUser[index]["gender"]}"),
                                  FittedBox(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${_filteredUser[index]["domain"]}",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        _filteredUser[index]["available"]
                                            ? const Icon(Icons.work_outline)
                                            : const Icon(
                                                Icons.work_off_outlined)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: FittedBox(
                                  child: Text(_filteredUser[index]["email"])),
                              trailing: IconButton(
                                  onPressed: () {
                                    addTeam(users[index]);
                                  },
                                  icon: const Icon(Icons.group_add_outlined)),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Center(
                        child: Text('No Employee Found'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 500,
                child: Filters(applyFilters),
              );
            },
          );
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
