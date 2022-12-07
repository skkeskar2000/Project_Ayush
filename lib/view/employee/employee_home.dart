import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as ma;
import 'package:major_project_fronted/preferences.dart';
import 'package:major_project_fronted/view/employee/sidenav/dashboard.dart';
import 'package:major_project_fronted/view/employee/sidenav/fillForm.dart';

class EmployeeHome extends StatefulWidget {
  const EmployeeHome({Key? key}) : super(key: key);

  @override
  State<EmployeeHome> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  int index = 0;
  List<Widget> formList = [];
  final formHeadingController = TextEditingController();
  String userId = '';

  @override
  void dispose() {
    // TODO: implement dispose
    formHeadingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    userId = SharedPreferenceHelper.getString(Preferences.userid)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
          title: Text("Fluent Design App Bar"),
          automaticallyImplyLeading: false),
      pane: NavigationPane(
          displayMode: PaneDisplayMode.auto,
          selected: index,
          onChanged: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.home),
              title: const Text("Home"),
              body: const ScaffoldPage(
                header: Text(
                  "Sample Page 1",
                  style: TextStyle(fontSize: 60),
                ),
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.view_dashboard),
              title: const Text("Dashboard"),
              body: ScaffoldPage(
                content: ma.Material(
                    child: userId.isNotEmpty
                        ? Dashboard(
                            userId: userId,
                          )
                        : null),
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.edit_create),
              title: const Text("Fill Form"),
              body: ScaffoldPage(
                header: Column(
                  children: const [
                    Center(
                      child: Text(
                        "Fill Form",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                    ma.Divider(
                      thickness: 1,
                    ),
                  ],
                ),
                content: ma.Material(
                  child: FillForm(),
                ),
              ),
            ),
          ],
          footerItems: [
            PaneItem(
                icon: const Icon(FluentIcons.help),
                title: const Text("Help"),
                body: const ScaffoldPage(
                  header: Text(
                    "Help",
                    style: TextStyle(fontSize: 60),
                  ),
                ),
            ),
            PaneItem(
                icon: const Icon(FluentIcons.album_remove),
                title: const Text("Logout"),
                body: const ScaffoldPage(
                  header: Text(
                    "Sample Page 2",
                    style: TextStyle(fontSize: 60),
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                }
            ),
          ]
      ),
    );
  }

  Container _formWidget({required String heading}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const ma.TextField(
            decoration: ma.InputDecoration(
              hintText: 'Enter The value',
              border: ma.OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  void _openDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: Text('Enter the heading'),
            content: TextBox(
              controller: formHeadingController,
            ),
            actions: [
              Button(
                autofocus: true,
                onPressed: () {
                  setState(() {
                    formList.add(
                      _formWidget(heading: formHeadingController.text),
                    );
                  });
                  formHeadingController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
              Button(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}
