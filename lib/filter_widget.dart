import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters(this.applyFilters, {super.key});
  final Function(String gender, bool avail, String department) applyFilters;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  late String gender;
  bool available = false;
  late String _currentItemSelected;
  final List<String> items = [
    'IT',
    'Sales',
    'Finance',
    'Marketing',
    'Management',
    'UI Designing',
    'Business Development',
  ];
  final List<String> genderList = [
    'Male',
    'Female',
    'Agender',
    'Polygender',
    'Non-binary',
    'Genderfluid',
    'Genderqueer',
  ];

  @override
  void initState() {
    super.initState();
    _currentItemSelected = items[0];
    gender = genderList[0];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: DecoratedBox(
        decoration: BoxDecoration(
          // color: Theme.of(context).,
          border: Border.all(color: Colors.black38, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Apply Filters ',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Gender : ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 189, 85, 224),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: PopupMenuButton<String>(
                        // color: Color.fromARGB(255, 189, 85, 224),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        itemBuilder: (context) {
                          return genderList.map((str) {
                            return PopupMenuItem(
                              value: str,
                              child: Text(str),
                            );
                          }).toList();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                gender,
                                style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        onSelected: (v) {
                          setState(() {
                            gender = v;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 30),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  const Text(
                    'Available: ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(width: 10),
                  Checkbox(
                    value: available,
                    onChanged: (value) {
                      setState(() {
                        available = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Row(
                children: [
                  const Text(
                    "Department : ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 189, 85, 224),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: PopupMenuButton<String>(
                        // color: Color.fromARGB(255, 189, 85, 224),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        itemBuilder: (context) {
                          return items.map((str) {
                            return PopupMenuItem(
                              value: str,
                              child: Text(str),
                            );
                          }).toList();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                _currentItemSelected,
                                style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        onSelected: (v) {
                          setState(() {
                            _currentItemSelected = v;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // padding: EdgeInsets.all(20),
                          backgroundColor: Color.fromARGB(255, 189, 85, 224),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          widget.applyFilters(
                              gender, available, _currentItemSelected);
                          Navigator.pop(context);
                        },
                        child: const Text('Apply')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
