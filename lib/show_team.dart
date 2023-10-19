import 'package:flutter/material.dart';

class ShowTeam extends StatefulWidget {
  const ShowTeam(this.team, {super.key});
  final List<Map<String, dynamic>> team;

  @override
  State<ShowTeam> createState() => _ShowTeamState();
}

class _ShowTeamState extends State<ShowTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Heliverse"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: widget.team.isNotEmpty
            ? ListView.builder(
                itemCount: widget.team.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    key: ValueKey(widget.team[index]["id"]),
                    color: Theme.of(context).colorScheme.inversePrimary,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 40,
                            child: Image.network(widget.team[index]["avatar"]),
                          )),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                                "${widget.team[index]["first_name"]} ${widget.team[index]["last_name"]}"),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("${widget.team[index]["gender"]}"),
                          FittedBox(
                            child: Row(
                              children: [
                                Text(
                                  "${widget.team[index]["domain"]}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                widget.team[index]["available"]
                                    ? const Icon(Icons.work_outline)
                                    : const Icon(Icons.work_off_outlined)
                              ],
                            ),
                          ),
                        ],
                      ),
                      subtitle:
                          FittedBox(child: Text(widget.team[index]["email"])),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.team.remove(widget.team[index]);
                            if (widget.team.isEmpty) {
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        icon: const Icon(Icons.group_remove_outlined),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text('Add Team Member'),
              ),
      ),
    );
  }
}
